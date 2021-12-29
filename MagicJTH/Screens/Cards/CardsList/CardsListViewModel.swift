//
//  CardsListViewModel.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine
import Foundation

class CardsListViewModel {
    
    // MARK: - Propiedades
    
    private let cardsRepository: CardsRepository
    private let navigator: Navigator
    @Published var cards = [CardDTO]()
    private var subscriptions = Set<AnyCancellable>()
    @Published var errorMessage: String?
    @Published var screenState: CardsListScreenState = .notSyncing
    
    // MARK: - Constructor
    
    init(cardsRepository: CardsRepository, navigator: Navigator) {
        self.cardsRepository = cardsRepository
        self.navigator = navigator
    }
    
    // MARK: - Métodos
    
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
    
    @objc func forceSync() {
        sync(forced: true)
    }
    
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
    
    func cardTapped(at index: Int) {
        let card = cards[index]
        navigator.navigateToCardDetail(card)
    }
    
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
    
    func resetErrorMessage() {
        errorMessage = nil
    }
    
}
