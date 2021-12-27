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
    
    // MARK: - Constructor
    
    init(remoteRepository: CardsRemoteRepository) {
        self.remoteRepository = remoteRepository
    }
    
    // MARK: - Métodos
    
    func read() -> AnyPublisher<Cards, Error> {
        remoteRepository.read()
    }
    
}
