//
//  Card.swift
//  Concentration
//
//  Created by Jeremy Heath on 12/29/18.
//  Copyright © 2018 Jeremy Heath. All rights reserved.
//

import Foundation

struct Card {
    
    static var newIdentifier = 0
    
    static func getNewIdentifier() -> Int {
        let returnIdentifier = newIdentifier
        newIdentifier += 1
        return returnIdentifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    
    init() {
        self.identifier = Card.getNewIdentifier()
    }
    
}
