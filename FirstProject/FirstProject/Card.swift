//
//  Card.swift
//  FirstProject
//
//  Created by Miroslav Shtregarski on 16.03.21.
//

import Foundation

struct Card {
    
    var cardIsFaceUp = false
    var cardIsMatched = false
    let cardUnicId : Int
    
    static var unicIdFactory = 0
    
    static func getUnicId() -> Int{
        unicIdFactory += 1
        return unicIdFactory
    }
    
    init() {
        self.cardUnicId = Card.getUnicId()
    }
}
