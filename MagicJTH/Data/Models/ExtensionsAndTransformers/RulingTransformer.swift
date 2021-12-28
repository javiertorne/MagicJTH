//
//  RulingTransformer.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import Foundation

class RulingTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let ruling = value as? RulingDTO else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: ruling, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let ruling = try NSKeyedUnarchiver.unarchivedObject(ofClass: RulingDTO.self, from: data)
            return ruling
        } catch {
            return nil
        }
    }
    
}

