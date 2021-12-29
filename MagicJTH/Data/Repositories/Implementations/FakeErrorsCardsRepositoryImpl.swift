//
//  FakeErrorsCardsRepositoryImpl.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 29/12/21.
//

import Combine

class FakeErrorsCardsRepositoryImpl: CardsRepository {
    
    func sync(completion: @escaping (Error?) -> Void) {
        
    }
    
    func read() -> AnyPublisher<CardsDTO, Error> {
        return Result<CardsDTO, Error>.Publisher(.failure(CustomError.unknown)).eraseToAnyPublisher()
    }
    
}
