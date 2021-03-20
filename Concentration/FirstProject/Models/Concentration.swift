//
//  Concentration.swift
//  Concentrtion
//
//  Created by Miroslav Shtregarski on 16.03.21.
//

import Foundation

class Concentration {
    weak var delegate: ConcentrationDelegateToViewController?
    var cards: [Card] = []
    private var alreadyFlippedCards = Set<Int>()
    private var score = 0
    private var firstFlippedCard: Int?, secondFlippedCard: Int?
    
    private var indexOfAlreadyOpenedCard : Int?
    
    func getCard(at index: Int){
        if !cards[index].cardIsMatched{
            //  # if picked card is not matched
            if let matchedIndex = indexOfAlreadyOpenedCard, matchedIndex != index{
                // # if we alredy have one card flipped
                if cards[matchedIndex].cardUniqueId == cards[index].cardUniqueId{
                    // # if alredy fliped and now fliped cars match
                    cards[matchedIndex].cardIsMatched = true
                    cards[index].cardIsMatched = true
                    score += 2
                    alreadyFlippedCards.remove(cards[index].cardUniqueId)
                    firstFlippedCard = nil
                    secondFlippedCard = nil
                }else{
                    // # if alredy fliped and now fliped cards don't match
                    if let veryFirstFlippedCard = firstFlippedCard{
                        score += alreadyFlippedCards.contains(veryFirstFlippedCard) ? -1 : 0
                        score += alreadyFlippedCards.contains(secondFlippedCard!) ? -1 : 0
                        score += alreadyFlippedCards.contains(cards[matchedIndex].cardUniqueId) ? -1 : 0
                        score += alreadyFlippedCards.contains(cards[index].cardUniqueId) ? -1 : 0
                        alreadyFlippedCards.insert(veryFirstFlippedCard)
                        alreadyFlippedCards.insert(secondFlippedCard!)
                        alreadyFlippedCards.insert(cards[matchedIndex].cardUniqueId)
                        alreadyFlippedCards.insert(cards[index].cardUniqueId)
                        firstFlippedCard = nil
                        secondFlippedCard = nil
                    }else{
                        firstFlippedCard = cards[matchedIndex].cardUniqueId
                        secondFlippedCard = cards[index].cardUniqueId
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
        delegate?.updateScorePoints(newScorePoints: score)
        delegate?.changeViewByModel()
    }
    
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
        delegate?.changeViewByModel()
    }
    
    init(pair pairsOfCards: Int) {
        for _ in 1...pairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
    
}


