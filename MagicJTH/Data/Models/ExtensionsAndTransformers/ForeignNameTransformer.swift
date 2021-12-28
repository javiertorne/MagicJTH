//
//  ForeignNameTransformer.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import Foundation

class ForeignNameTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let foreignName = value as? ForeignNameDTO else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: foreignName, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let foreignName = try NSKeyedUnarchiver.unarchivedObject(ofClass: ForeignNameDTO.self, from: data)
            return foreignName
        } catch {
            return nil
        }
    }
    
}

