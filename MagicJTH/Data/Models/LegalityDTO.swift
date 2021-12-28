//
//  LegalityDTO.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import Foundation

public class LegalityDTO: NSObject, NSCoding, Codable {
    let format: String?
    let legality: String?
    
    init(format: String?, legality: String?) {
        self.format = format
        self.legality = legality
    }
    
    required public init(coder aDecoder: NSCoder) {
        format = aDecoder.decodeObject(forKey: "format") as? String ?? ""
        legality = aDecoder.decodeObject(forKey: "legality") as? String ?? ""
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(format, forKey: "format")
        aCoder.encode(legality, forKey: "legality")
    }
}
