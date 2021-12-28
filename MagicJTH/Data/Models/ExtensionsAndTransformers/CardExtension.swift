//
//  CardExtension.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import Foundation
import CoreData

extension Card {
    
    func mapToCardDTO() -> CardDTO {
        return CardDTO(
            name: name,
            manaCost: manaCost,
            cmc: cmc,
            colors: colors,
            colorIdentity: colorIdentity,
            type: type,
            types: types,
            subtypes: subtypes,
            rarity: rarity,
            cardSet: cardSet,
            setName: setName,
            text: text,
            flavor: flavor,
            artist: artist,
            number: number,
            power: power,
            toughness: toughness,
            layout: layout,
            multiverseid: multiverseid,
            imageURL: imageURL,
            printings: printings,
            originalText: originalText,
            originalType: originalType,
            legalities: legalities,
            id: id,
            watermark: watermark,
            rulings: rulings,
            variations: variations,
            supertypes: supertypes,
            foreignNames: foreignNames
        )
    }
    
    func mapFromCardDTO(_ dto: CardDTO, context: NSManagedObjectContext) {
        name = dto.name
        manaCost = dto.manaCost
        cmc = dto.cmc ?? -1
        colors = dto.colors
        colorIdentity = dto.colorIdentity
        type = dto.type
        types = dto.types
        subtypes = dto.subtypes
        rarity = dto.rarity
        cardSet = dto.cardSet
        setName = dto.setName
        text = dto.text
        flavor = dto.flavor
        artist = dto.artist
        number = dto.number
        power = dto.power
        toughness = dto.toughness
        layout = dto.layout
        multiverseid = dto.multiverseid
        imageURL = dto.imageURL
        printings = dto.printings
        originalText = dto.originalText
        originalType = dto.originalType
        legalities = dto.legalities
        //legalities = nil
        id = dto.id
        watermark = dto.watermark
        //rulings = dto.rulings
        rulings = nil
        variations = dto.variations
        supertypes = dto.supertypes
        //foreignNames = dto.foreignNames
        foreignNames = nil
    }
    
}
