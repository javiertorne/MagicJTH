//
//  RepositoriesDependencyContainer.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

class RepositoriesDependencyContainer {
    
    // MARK: - Cards
    
    func makeCardsRepository() -> CardsRepository {
        let cardsRemotesRepository = makeCardsRemoteRepository()
        let cardsLocalRepository = makeCardsLocalRepository()
        return CardsRepositoryImpl(
            remoteRepository: cardsRemotesRepository,
            localRepository: cardsLocalRepository
        )
    }
    
    private func makeCardsRemoteRepository() -> CardsRemoteRepository {
        CardsRemoteRepositoryImpl()
    }
    
    private func makeCardsLocalRepository() -> CardsLocalRepository {
        CardsLocalRepositoryImpl()
    }
    
}
