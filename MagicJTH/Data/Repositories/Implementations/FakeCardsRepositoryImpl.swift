//
//  FakeCardsRepositoryImpl.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 29/12/21.
//

import Combine

class FakeCardsRepositoryImpl: CardsRepository {
    
    func sync(completion: @escaping (Error?) -> Void) {
        
    }
    
    func read() -> AnyPublisher<CardsDTO, Error> {
        return Result<CardsDTO, Error>.Publisher(.success(CardsDTO(cards: [CardDTO(name: "Test", manaCost: "Test", cmc: 0, colors: ["Test"], colorIdentity: ["Test"], type: "Test", types: ["Test"], subtypes: ["Test"], rarity: "Test", cardSet: "Test", setName: "Test", text: "Test", flavor: "Test", artist: "Test", number: "Test", power: "Test", toughness: "Test", layout: "Test", multiverseid: "Test", imageURL: "Test", printings: ["Test"], originalText: "Test", originalType: "Test", legalities: nil, id: "Test", watermark: "Test", rulings: nil, variations: ["Test"], supertypes: ["Test"], foreignNames: nil)]))).eraseToAnyPublisher()
    }
    
}
