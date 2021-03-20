//
//  ConcentrationCard.swift
//  Concentration
//
//  Created by Miroslav Shtregarski on 16.03.21.
//

import Foundation

struct Card {
    
    var cardIsFaceUp = false
    var cardIsMatched = false
    let cardUniqueId : Int
    
    private static var makeUniqueID = 0
    
    private static func getUniqueId() -> Int{
        makeUniqueID += 1
        return makeUniqueID
    }
    
    init() {
        self.cardUniqueId = Card.getUniqueId()
    }
}
