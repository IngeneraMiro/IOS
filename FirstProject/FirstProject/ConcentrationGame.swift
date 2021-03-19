//
//  ConcentrationGame.swift
//  FirstProject
//
//  Created by Miroslav Shtregarski on 16.03.21.
//

import Foundation

class Concentration {
    weak  var delegate: someMethodsDelegation?
    var cards = Array<Card>()
    var alreadyFlippedCards = Set<Int>()
    var score = 0
    var firstFlippedCard: Int?, secondFlippedCard: Int?
    
    var indexOfAlreadyOpenedCard : Int?
    
    func getCard(at index: Int){
        if !cards[index].cardIsMatched{
            if let matchIndex = indexOfAlreadyOpenedCard, matchIndex != index{
                if cards[matchIndex].cardUnicId == cards[index].cardUnicId{
                    cards[matchIndex].cardIsMatched = true
                    cards[index].cardIsMatched = true
                    score += 2
                    alreadyFlippedCards.remove(cards[index].cardUnicId)
                    firstFlippedCard = nil
                    secondFlippedCard = nil
                }else{
                    if let firstRounded = firstFlippedCard{
                        score += alreadyFlippedCards.contains(firstRounded) ? -1 : 0
                        score += alreadyFlippedCards.contains(secondFlippedCard!) ? -1 : 0
                        score += alreadyFlippedCards.contains(cards[matchIndex].cardUnicId) ? -1 : 0
                        score += alreadyFlippedCards.contains(cards[index].cardUnicId) ? -1 : 0
                        alreadyFlippedCards.insert(firstRounded)
                        alreadyFlippedCards.insert(secondFlippedCard!)
                        alreadyFlippedCards.insert(cards[matchIndex].cardUnicId)
                        alreadyFlippedCards.insert(cards[index].cardUnicId)
                        firstFlippedCard = nil
                        secondFlippedCard = nil
                    }else{
                        firstFlippedCard = cards[matchIndex].cardUnicId
                        secondFlippedCard = cards[index].cardUnicId
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
            
            delegate?.updateFlippedCrdsCounter(counterIncrement: 1)
        }else{
            delegate?.updateFlippedCrdsCounter(counterIncrement: 0)
        }
        delegate?.updateScorePoints(newScorePoints: score)    }
    
    func gameRestart(){
        for index in cards.indices{
            cards[index].cardIsFaceUp = false
            cards[index].cardIsMatched = false
        }
        cards.shuffle()
        score = 0
        alreadyFlippedCards.removeAll()
        firstFlippedCard = nil
        secondFlippedCard = nil
        indexOfAlreadyOpenedCard = nil
        delegate?.softwareRestartTheGame()
    }
    
    init(pair pairsOfCards: Int) {
        for _ in 1...pairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
    
}


