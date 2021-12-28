//
//  CardsRepository.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine

protocol CardsRepository {
    
    func sync(completion: @escaping (Error?) -> Void)
    func read() -> AnyPublisher<CardsDTO, Error>
    
}
