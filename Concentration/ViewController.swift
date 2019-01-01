//
//  ViewController.swift
//  Concentration
//
//  Created by Jeremy Heath on 12/27/18.
//  Copyright © 2018 Jeremy Heath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOfCards = 8
    var currentTheme = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initializeCardEmojis()
    }
    
    func initializeCardEmojis() {
        
        //Need to use a random number generator here to assign emojis
        unusedEmojis = emojiThemes[currentTheme]
        
        for card in 0..<(numberOfCards / 2) {
            let randomNumber = Int.random(in: 0..<unusedEmojis.count)
            emojiDictionary.updateValue(unusedEmojis.remove(at: randomNumber), forKey: card)
        }
    }
    
    func updateViewFromModel() {
        
        for Index in 0..<numberOfCards {
            
            cardButton[Index].isHidden = game.cardArray[Index].isMatched
            
            if game.cardArray[Index].isFaceUp {
                cardButton[Index].setTitle(emojiDictionary[game.cardArray[Index].identifier], for: UIControl.State.normal)
            }
            else {
                cardButton[Index].setTitle("", for: UIControl.State.normal)
            }
        }
        
        scoreLabel.text = String(game.score)
    }
    
    lazy var game = ConcentrationGame(numberOfCards)
    
    var emojiDictionary: [Int: String] = [:]
    
    var emojiThemes = [["🐶", "🐼", "🐷", "🐨"],
                       ["🍏","🍊","🍕","🍔"]]
    
    var unusedEmojis = [String]()// ctrl cmd space

    @IBOutlet var cardButton: [UIButton]!
    
    @IBAction func handleNewGame(_ sender: UIButton) {
        
        if currentTheme < emojiThemes.count - 1 {
            currentTheme += 1
        }
        else {
            currentTheme = 0
        }
        
        game.newGame()
        initializeCardEmojis()
        updateViewFromModel()
    }
    @IBAction func handleCardHit(_ sender: UIButton) {
        let indexSelected = cardButton.index(of : sender)
        game.flipCard(indexSelected!)
        updateViewFromModel()
    }
}

