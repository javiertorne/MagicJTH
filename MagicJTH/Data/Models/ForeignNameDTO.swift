//
//  ForeignNameDTO.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import Foundation

public class ForeignNameDTO: NSObject, NSCoding, Codable {
    let name: String?
    let text: String?
    let type: String?
    let flavor: String?
    let imageURL: String?
    let language: String?
    let multiverseid: Int64?
    
    init(name: String?, text: String?, type: String?, flavor: String?, imageURL: String?, language: String?, multiverseid: Int64?) {
        self.name = name
        self.text = text
        self.type = type
        self.flavor = flavor
        self.imageURL = imageURL
        self.language = language
        self.multiverseid = multiverseid
    }
    
    required public init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        text = aDecoder.decodeObject(forKey: "text") as? String ?? ""
        type = aDecoder.decodeObject(forKey: "type") as? String ?? ""
        flavor = aDecoder.decodeObject(forKey: "flavor") as? String ?? ""
        imageURL = aDecoder.decodeObject(forKey: "imageURL") as? String ?? ""
        language = aDecoder.decodeObject(forKey: "language") as? String ?? ""
        multiverseid = aDecoder.decodeObject(forKey: "multiverseid") as? Int64 ?? 0
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(flavor, forKey: "flavor")
        aCoder.encode(imageURL, forKey: "imageURL")
        aCoder.encode(language, forKey: "language")
        aCoder.encode(multiverseid, forKey: "multiverseid")
    }
}
