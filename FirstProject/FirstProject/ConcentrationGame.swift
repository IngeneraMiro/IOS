//
//  ConcentrationGame.swift
//  FirstProject
//
//  Created by Miroslav Shtregarski on 16.03.21.
//

import Foundation

class Concentration {
  weak  var delegate: RestartDelegation?
    var cards = Array<Card>()
    var alreadyFlippedCards = Set<Int>()
    var score = 0
    var card1: Int?, card2: Int?
    
    var indexOfAlreadyOpenedCard : Int?
    
    func getCard(at index: Int) -> (Int,Int){
        if !cards[index].cardIsMatched{
            if let matchIndex = indexOfAlreadyOpenedCard, matchIndex != index{
                if cards[matchIndex].cardUnicId == cards[index].cardUnicId{
                    cards[matchIndex].cardIsMatched = true
                    cards[index].cardIsMatched = true
                    score += 2
                    alreadyFlippedCards.remove(cards[index].cardUnicId)
                    card1 = nil
                    card2 = nil
                }else{
                    if let firstRounded = card1{
                        score += alreadyFlippedCards.contains(firstRounded) ? -1 : 0
                        score += alreadyFlippedCards.contains(card2!) ? -1 : 0
                        score += alreadyFlippedCards.contains(cards[matchIndex].cardUnicId) ? -1 : 0
                        score += alreadyFlippedCards.contains(cards[index].cardUnicId) ? -1 : 0
                        alreadyFlippedCards.insert(firstRounded)
                        alreadyFlippedCards.insert(card2!)
                        alreadyFlippedCards.insert(cards[matchIndex].cardUnicId)
                        alreadyFlippedCards.insert(cards[index].cardUnicId)
                        card1 = nil
                        card2 = nil
                    }else{
                        card1 = cards[matchIndex].cardUnicId
                        card2 = cards[index].cardUnicId
                        
                    }
                }
                cards[index].cardIsFaceUp = true
                indexOfAlreadyOpenedCard = nil
                
            }else{
                for flipIndex in cards.indices{
                    cards[flipIndex].cardIsFaceUp = false
                }
                cards[index].cardIsFaceUp = true
                indexOfAlreadyOpenedCard = index
            }
            return (1,score)
        }else{
            return (0,score)
        }
        
    }
    
    func gameRestart(){
        for index in cards.indices{
            cards[index].cardIsFaceUp = false
            cards[index].cardIsMatched = false
        }
        cards.shuffle()
        score = 0
        alreadyFlippedCards.removeAll()
        card1 = nil
        card2 = nil
        indexOfAlreadyOpenedCard = nil
        delegate?.restarting()
    }
    
    init(pair pairsOfCards: Int) {
        for _ in 1...pairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
    
}


