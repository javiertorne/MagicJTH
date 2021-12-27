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
        return CardsRepositoryImpl(remoteRepository: cardsRemotesRepository)
    }
    
    private func makeCardsRemoteRepository() -> CardsRemoteRepository {
        CardsRemoteRepositoryImpl()
    }
    
}
