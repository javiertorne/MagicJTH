//
//  CardsRepository.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine

protocol CardsRepository {
    
    func read() -> AnyPublisher<[Card], Error>
    
}
