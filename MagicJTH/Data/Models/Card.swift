//
//  Card.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

struct Card: Codable {
    let name, manaCost: String?
    let cmc: Int?
    let colors, colorIdentity: [String]?
    let type: String?
    let types, subtypes: [String]?
    let rarity, cardSet, setName, text: String?
    let flavor, artist, number, power: String?
    let toughness, layout, multiverseid: String?
    let imageURL: String?
    let printings: [String]?
    let originalText, originalType: String?
    let legalities: [Legality]?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case name, manaCost, cmc, colors, colorIdentity, type, types, subtypes, rarity
        case cardSet = "set"
        case setName, text, flavor, artist, number, power, toughness, layout, multiverseid
        case imageURL = "imageUrl"
        case printings, originalText, originalType, legalities, id
    }
}

// MARK: - Legality
struct Legality: Codable {
    let format, legality: String?
}
