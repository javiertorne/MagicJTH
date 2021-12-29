//
//  CardsListViewModel.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine
import Foundation

/// View model para la pantalla de listado de cartas.
class CardsListViewModel {
    
    // MARK: - Propiedades
    
    /// Repositorio de cartas
    private let cardsRepository: CardsRepository
    
    /// Navigator utilizado para la movilidad entre pantallas.
    private let navigator: Navigator
    
    /// Publisher que expone una colección de cartas.
    @Published var cards = [CardDTO]()
    
    /// Publisher que expone si hay algún mensaje de error.
    @Published var errorMessage: String?
    
    /// Publisher que expone el estado en el que se encuentra la pantalla.
    @Published var screenState: CardsListScreenState = .notSyncing
    
    /// Set de suscripciones de Combine. Se almacenan a nivel de clase para que se liberen cuando el sistema libere de memoria esta clase.
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Constructor
    
    /**
     Inicializa un nuevo view model del listado de cartas con todas sus dependencias.
     
     - Parameters:
     - cardsRepository: Repositorio de cartas.
     - navigator: Encargado de la navegación entre pantallas.
     
     - Returns: Un nuevo view model de listado de cartas.
     */
    init(cardsRepository: CardsRepository, navigator: Navigator) {
        self.cardsRepository = cardsRepository
        self.navigator = navigator
    }
    
    // MARK: - Métodos
    
    /**
     Obtener todas las cartas de Magic.
     
     - Parameter completion: Closure que se utiliza para notificar cuando ha terminado el proceso de obtener las cartas. Es opcional porque sólo se utiliza para que el view controller sepa que ha terminado y comience la sincronización de datos entre remoto y local. Sin embargo, cuando se llama a esta función desde el propio view model, no es necesario realizar la sincronización, por lo que éste parámetro sería nulo.
     */
    func fetchAllCards(completion: (() -> Void)? = nil) {
        cardsRepository
            .read()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = self?.getErrorMessage(error: error)
                    break
                case .finished:
                    break
                }
            } receiveValue: { [weak self] cards in
                guard let theCards = cards.cards else { return }
                self?.cards = theCards
                guard let completion = completion else {
                    return
                }
                completion()
            }
            .store(in: &subscriptions)
    }
    
    /**
     Forzar una sincronización mediante el botón de la barra de navegación.
     */
    @objc func forceSync() {
        sync(forced: true)
    }
    
    /**
     Sincronizar los datos remotos y locales. Para ello, se obtienen los datos de remoto, se borran todos los datos locales y se insertan de nuevo.
     
     - Parameter forced: Booleano que se utiliza para cambiar el estado de la pantalla. Es necesario para poder mostrar adecuadamente el indicador de "cargando". Por defecto es falso.
     */
    func sync(forced: Bool = false) {
        screenState = forced ? .forceSyncing : .syncing
        cardsRepository.sync { [weak self] error in
            self?.screenState = .notSyncing
            if error != nil {
                if let cards = self?.cards, cards.isEmpty {
                    self?.errorMessage = self?.getErrorMessage(error: error!)
                }
            } else {
                self?.fetchAllCards()
            }
        }
    }
    
    /**
     Función que se llama cuando se pulsa sobre una carta dentro del listado de cartas.
     
     - Parameter at: Índice de la carta que se ha pulsado.
     */
    func cardTapped(at index: Int) {
        let card = cards[index]
        navigator.navigateToCardDetail(card)
    }
    
    /**
     Obtener el mensaje de error que se le va a mostrar al usuario a partir de un error.
     
     - Parameter error: Error que ha sucedido en algún momento al intentar leer los datos.
     - Returns: Un texto con el mensaje de error en el idioma en el que el usuario tenga el dispositivo configurado.
     */
    private func getErrorMessage(error: Error) -> String {
        if error is CustomError {
            switch error as! CustomError {
            case .noInternet:
                return "error.no_internet".localized()
            case .unknown:
                return "error.unknown".localized()
            default:
                return "error.other".localized()
            }
        }
        
        return "error.unknown".localized()
    }
    
    /**
     Resetear el mensaje de error y ponerlo a nulo.
     */
    func resetErrorMessage() {
        errorMessage = nil
    }
    
}
