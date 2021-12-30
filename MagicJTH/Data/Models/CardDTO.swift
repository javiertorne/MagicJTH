//
//  CardDTO.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

struct CardsDTO: Codable {
    let cards: [CardDTO]?
    
    enum CodingKeys: String, CodingKey {
        case cards
    }
}

struct CardDTO: Codable {
    let name: String?
    let manaCost: String?
    let cmc: Double?
    let colors: [String]?
    let colorIdentity: [String]?
    let type: String?
    let types: [String]?
    let subtypes: [String]?
    let rarity: String?
    let cardSet: String?
    let setName: String?
    let text: String?
    let flavor: String?
    let artist: String?
    let number: String?
    let power: String?
    let toughness: String?
    let layout: String?
    let multiverseid: String?
    let imageURL: String?
    let printings: [String]?
    let originalText: String?
    let originalType: String?
    let legalities: [LegalityDTO]?
    let id: String?
    let watermark: String?
    let rulings: [RulingDTO]?
    let variations: [String]?
    let supertypes: [String]?
    let foreignNames: [ForeignNameDTO]?
    
    enum CodingKeys: String, CodingKey {
        case name, manaCost, cmc, colors, colorIdentity, type, types, subtypes, rarity, setName, text, flavor, artist, number, power, toughness, layout, multiverseid, printings, originalText, originalType, legalities, id, watermark, rulings, variations, supertypes, foreignNames
        case cardSet = "set"
        case imageURL = "imageUrl"
    }
}

