//
//  PersistentContainer.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import CoreData

class PersistentContainer: NSPersistentContainer {
    
    static let shared = PersistentContainer(name: "Main")
    
    func setup() {
        loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error {
                fatalError("Error al cargar el contenedor de Core Data: \(error.localizedDescription)")
            }
        })
    }
    
}
