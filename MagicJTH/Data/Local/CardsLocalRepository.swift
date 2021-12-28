//
//  CardsLocalRepository.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import Combine

protocol CardsLocalRepository {
    
    func read() -> AnyPublisher<CardsDTO, Error>
    func save(_ cards: [CardDTO], completion: @escaping (Error?) -> Void)
    
}
