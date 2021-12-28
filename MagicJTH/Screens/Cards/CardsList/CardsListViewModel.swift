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
    @Published var cards = [Card]()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Constructor
    
    init(cardsRepository: CardsRepository) {
        self.cardsRepository = cardsRepository
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
                print(theCards)
            }
            .store(in: &subscriptions)
    }
    
}
