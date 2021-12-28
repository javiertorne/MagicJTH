//
//  CardsRemoteRepository.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine

protocol CardsRemoteRepository {
    
    func read() -> AnyPublisher<CardsDTO, Error>
    
}
