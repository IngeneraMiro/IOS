//
//  ViewController.swift
//  Memory
//
//  Created by Miroslav Shtregarski on 12.03.21.
//

import UIKit

class ViewController: UIViewController, someMethodsDelegation {
    
   override func viewDidLoad() {
        super.viewDidLoad()
        game.delegate = self
        
    }
    
    func updateScorePoints(newScorePoints: Int) {
        score = newScorePoints
    }
    
    func updateFlippedCrdsCounter(counterIncrement: Int) {
        flipCounter += counterIncrement
    }
    
    lazy var game = Concentration(pair:(cardCollection.count+1)/2)
    
    var flipCounter = 0 {
        didSet {
            flipCardLable.text = "Flips: \(flipCounter)"
        }
    }
    var score = 0 {
        didSet{
            scoreCounter.text = "score: \(score)"
        }
    }
    
    @IBOutlet weak var flipCardLable: UILabel!
    @IBOutlet weak var scoreCounter: UILabel!
    
    
    @IBAction func restartTheGame(_ sender: UIButton) {
        game.gameRestart()
    }
    
    @IBOutlet var cardCollection: [UIButton]!
    
    @IBAction func cardTouch(_ sender: UIButton) {
        if let cardNumber = cardCollection.firstIndex(of: sender){
            game.getCard(at: cardNumber)
            changeViewByModel()
        }else{
            print("there is a bug - no such card in collection")
        }
    }
    
    func changeViewByModel(){
        for index in cardCollection.indices{
            let button = cardCollection[index]
            let card = game.cards[index]
            if card.cardIsFaceUp {
                button.setTitle(emojiForCard(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle(card.cardIsMatched ? "" : "🕷", for: UIControl.State.normal)
                button.backgroundColor = card.cardIsMatched ? #colorLiteral(red: 1, green: 0.7006285493, blue: 0.1696278834, alpha: 0) : #colorLiteral(red: 1, green: 0.7006285493, blue: 0.1696278834, alpha: 1)
            }
        }
    }
    
    func softwareRestartTheGame(){
        emoji.removeAll()
        pictures = Theme.getRandomTheme()
        flipCounter = 0
        score = 0
        changeViewByModel()
    }
    
    var pictures = Theme.getRandomTheme()
    
    var emoji = [Int:String]()
    
    func emojiForCard(for card: Card) -> String {
        if emoji[card.cardUniqueId] == nil, !pictures.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(pictures.count)))
            emoji[card.cardUniqueId] = pictures.remove(at: randomIndex)
        }
        return emoji[card.cardUniqueId] ?? "?"
    }
    
    
}

