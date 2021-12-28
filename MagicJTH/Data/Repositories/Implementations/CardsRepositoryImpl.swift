//
//  CardsRepositoryImpl.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine

class CardsRepositoryImpl: CardsRepository {
    
    // MARK: - Propiedades
    
    private let remoteRepository: CardsRemoteRepository
    private let localRepository: CardsLocalRepository
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Constructor
    
    init(remoteRepository: CardsRemoteRepository, localRepository: CardsLocalRepository) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    // MARK: - Métodos
    
    func sync(completion: @escaping (Error?) -> Void) {
        remoteRepository.read()
            .sink { completed in
                switch completed {
                case .failure(let error):
                    /*let errorMessage = ErrorMessage(
                        title: "general.alert_message.error".localized(),
                        message: error.localizedDescription
                    )*/
                    completion(error)
                    break
                case .finished:
                    break
                }
            } receiveValue: { [weak self] cards in
                if let cardsDTO = cards.cards {
                    self?.localRepository.save(cardsDTO) { error in
                        completion(error)
                    }
                }
            }
            .store(in: &subscriptions)
    }
    
    func read() -> AnyPublisher<CardsDTO, Error> {
        localRepository.read()
    }
    
}
