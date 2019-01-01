//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Jeremy Heath on 12/29/18.
//  Copyright © 2018 Jeremy Heath. All rights reserved.
//

import Foundation

class ConcentrationGame {
    
    var cardArray = [Card]()
    var cardSeenArray = [Int]()
    var oneAndOnlyOneCardSelected: Int?
    var clearFaceUpNextHit = false
    var score = 0
    
    func flipCard(_ Index : Int) {
    
        
        if clearFaceUpNextHit {
            for Index in 0 ..< cardArray.count {
                cardArray[Index].isFaceUp = false
            }
            clearFaceUpNextHit = false
        }
        if oneAndOnlyOneCardSelected == nil {
            oneAndOnlyOneCardSelected =  Index
            cardArray[Index].isFaceUp = true
        }
        else if cardArray[Index].identifier == cardArray[oneAndOnlyOneCardSelected!].identifier && Index != oneAndOnlyOneCardSelected {
            cardArray[Index].isMatched = true
            cardArray[oneAndOnlyOneCardSelected!].isMatched = true
            oneAndOnlyOneCardSelected = nil
            score += 2
            //matched
        }
        else {
            cardArray[Index].isFaceUp = true
            clearFaceUpNextHit = true
            
            //mismatch, deduct points for each card that has already been seen
            if cardSeenArray.contains(Index) {
                score -= 1
            }
            
            if oneAndOnlyOneCardSelected != nil {
                
                if cardSeenArray.contains(oneAndOnlyOneCardSelected!) {
                    score -= 1
                }
            }
            if !cardSeenArray.contains(Index) {
                cardSeenArray.append(Index)
            }
            
            if oneAndOnlyOneCardSelected != nil {
                if !cardSeenArray.contains(oneAndOnlyOneCardSelected!) {
                    cardSeenArray.append(oneAndOnlyOneCardSelected!)
                }
            }
            oneAndOnlyOneCardSelected = nil
        }
        
    }
    
    func isCardAlreadyFaceUp() -> Bool {
        for Index in 0 ..< cardArray.count {
            if !cardArray[Index].isMatched && cardArray[Index].isFaceUp {
                return true
            }
        }
        return false
    }
    
    func shuffleCards() {
        for Index in 0 ..< cardArray.count {
            let randomValue = Int.random(in: 0..<cardArray.count)
            let tempCard = cardArray[Index]
            cardArray[Index] = cardArray[randomValue]
            cardArray[randomValue] = tempCard
        }
    }
    
    init(_ numberOfCards : Int) {
        
        for _ in 1...(numberOfCards / 2) {
            let card = Card()
            cardArray.append(card)
            cardArray.append(card)
        }
        
        shuffleCards()
    }
    
    func newGame() {
        
        for Index in 0..<cardArray.count {
            cardArray[Index].isMatched = false
            cardArray[Index].isFaceUp = false
        }
        cardSeenArray.removeAll()
        shuffleCards()
        score = 0
    }
}


