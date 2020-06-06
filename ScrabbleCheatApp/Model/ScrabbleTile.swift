//
//  ScrabbleTile.swift
//  ScrabbleCheat
//
//  Created by Jody Abney on 6/1/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct ScrabbleTile {
    
    var letter: String
    var pointValue: Int
    
}

struct ScrabbleTiles {
    var tiles = [
        ScrabbleTile(letter: "A", pointValue: 1),
        ScrabbleTile(letter: "B", pointValue: 3),
        ScrabbleTile(letter: "C", pointValue: 3),
        ScrabbleTile(letter: "D", pointValue: 2),
        ScrabbleTile(letter: "E", pointValue: 1),
        ScrabbleTile(letter: "F", pointValue: 4),
        ScrabbleTile(letter: "G", pointValue: 2),
        ScrabbleTile(letter: "H", pointValue: 4),
        ScrabbleTile(letter: "I", pointValue: 1),
        ScrabbleTile(letter: "J", pointValue: 8),
        ScrabbleTile(letter: "K", pointValue: 5),
        ScrabbleTile(letter: "L", pointValue: 1),
        ScrabbleTile(letter: "M", pointValue: 3),
        ScrabbleTile(letter: "N", pointValue: 1),
        ScrabbleTile(letter: "O", pointValue: 1),
        ScrabbleTile(letter: "P", pointValue: 3),
        ScrabbleTile(letter: "Q", pointValue: 10),
        ScrabbleTile(letter: "R", pointValue: 1),
        ScrabbleTile(letter: "S", pointValue: 1),
        ScrabbleTile(letter: "T", pointValue: 1),
        ScrabbleTile(letter: "U", pointValue: 1),
        ScrabbleTile(letter: "V", pointValue: 4),
        ScrabbleTile(letter: "W", pointValue: 4),
        ScrabbleTile(letter: "X", pointValue: 8),
        ScrabbleTile(letter: "Y", pointValue: 4),
        ScrabbleTile(letter: "Z", pointValue: 10)
    ]
    
    func getTile(letter: String) -> ScrabbleTile {
        if let tile = tiles.first(where: { $0.letter == letter }) {
            return tile
        }
        return ScrabbleTile(letter: "####", pointValue: 0)
    }
}
