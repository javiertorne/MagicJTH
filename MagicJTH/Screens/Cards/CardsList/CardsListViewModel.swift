//
//  CardsListViewModel.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine

class CardsListViewModel {
    
    // MARK: - Propiedades
    
    private let cardsRepository: CardsRepository
    private let navigator: Navigator
    @Published var cards = [Card]()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Constructor
    
    init(cardsRepository: CardsRepository, navigator: Navigator) {
        self.cardsRepository = cardsRepository
        self.navigator = navigator
    }
    
    // MARK: - Métodos
    
    func fetchAllCards() {
        cardsRepository
            .read()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                case .finished:
                    break
                }
            } receiveValue: { [weak self] cards in
                guard let theCards = cards.cards else { return }
                self?.cards = theCards
            }
            .store(in: &subscriptions)
    }
    
    func cardTapped(at index: Int) {
        let card = cards[index]
        navigator.navigateToCardDetail(card)
    }
    
}
