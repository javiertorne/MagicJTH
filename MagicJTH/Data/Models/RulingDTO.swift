//
//  RulingDTO.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import Foundation

public class RulingDTO: NSObject, NSCoding, Codable {
    let date: String?
    let text: String?
    
    init(date: String?, text: String?) {
        self.date = date
        self.text = text
    }
    
    required public init(coder aDecoder: NSCoder) {
        date = aDecoder.decodeObject(forKey: "date") as? String ?? ""
        text = aDecoder.decodeObject(forKey: "text") as? String ?? ""
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(text, forKey: "text")
    }
}
