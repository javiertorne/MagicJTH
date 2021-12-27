//
//  CardsRemoteRepositoryImpl.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine

class CardsRemoteRepositoryImpl: CardsRemoteRepository {
    
    func read() -> AnyPublisher<Cards, Error> {
        API.shared.get(endpoint: .cardsList)
    }
    
}
