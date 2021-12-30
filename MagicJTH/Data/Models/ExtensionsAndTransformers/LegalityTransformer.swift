//
//  LegalityTransformer.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import Foundation

/// Clase que transforma una clase de tipo LegalityDTO en datos que puede guardar Core Data.
class LegalityTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let legality = value as? LegalityDTO else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: legality, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let legality = try NSKeyedUnarchiver.unarchivedObject(ofClass: LegalityDTO.self, from: data)
            return legality
        } catch {
            return nil
        }
    }
    
}
