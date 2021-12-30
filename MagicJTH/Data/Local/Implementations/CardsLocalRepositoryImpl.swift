//
//  CardsLocalRepositoryImpl.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import CoreData
import Combine

class CardsLocalRepositoryImpl: CardsLocalRepository {
    
    func read() -> AnyPublisher<CardsDTO, Error> {
        let fetchRequest = NSFetchRequest<Card>(entityName: "Card")
        do {
            let cards = try PersistentContainer.shared.viewContext.fetch(fetchRequest)
            let cardDTOArray = cards.map { card in
                card.mapToCardDTO()
            }
            let cardsDTO = CardsDTO(cards: cardDTOArray)
            return Result<CardsDTO, Error>.Publisher(.success(cardsDTO)).eraseToAnyPublisher()
        } catch let error {
            return Result<CardsDTO, Error>.Publisher(.failure(error)).eraseToAnyPublisher()
        }
    }
    
    func save(_ cards: [CardDTO], completion: @escaping (Error?) -> Void) {
        PersistentContainer.shared.performBackgroundTask { [weak self] context in
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Card")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                       
            let batchInsert = self?.newBatchInsertRequest(with: cards, context: context)
            guard let batchInsert = batchInsert else { return }
            do {
                try context.execute(deleteRequest)
                try context.execute(batchInsert)
                
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    private func newBatchInsertRequest(with cards: [CardDTO], context: NSManagedObjectContext) -> NSBatchInsertRequest {
        var index = 0
        let total = cards.count
        
        let batchInsert = NSBatchInsertRequest(entity: Card.entity()) { (managedObject: NSManagedObject) -> Bool in
            guard index < total else { return true }
            
            if let card = managedObject as? Card {
                let data = cards[index]
                card.mapFromCardDTO(data, context: context)
            }
            
            index += 1
            return false
        }
        return batchInsert
    }
    
}
