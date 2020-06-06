//
//  ScrabbleBrain.swift
//  ScrabbleCheat
//
//  Created by Jody Abney on 6/1/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct ScrabbleBrain {
    
    //MARK: - Properties
    private let numberOfPlayerTiles = 7
    private let scrabbleTiles = ScrabbleTiles()
    private var bag: [ScrabbleTile] = []
    private(set) public var playerTiles: [ScrabbleTile] = []
    // use the letters from the player tiles
    private var rack: [String] = []
    // array of dictionary words that match the player tile permutations
    private(set) public var matchedWords: [(String, Int)] = []
    // the set of tile permutations to be searched
    private var searchGroup = Set<String>()
    // Trie-based dictionary model
    private let dictionary = Trie<String>()
    
    //MARK: - Instance Methods
    public mutating func setup() {
        createDictionary()
        fillBagWithTiles()
        getPlayerTiles()
    }
    
    private func createDictionary() {
        for word in ParseDictionaryFile.readDictionary() {
            dictionary.insert(word)
        }
    }
    
    private mutating func fillBagWithTiles() {
        bag.removeAll()
        // generate A and I tiles
        for _ in 0..<9 {
            bag.append(scrabbleTiles.getTile(letter: "A"))
            bag.append(scrabbleTiles.getTile(letter: "I"))
        }
        // generate B, C, F, H, M, P, V, W, and Y tiles
        for _ in 0..<2 {
            bag.append(scrabbleTiles.getTile(letter: "B"))
            bag.append(scrabbleTiles.getTile(letter: "C"))
            bag.append(scrabbleTiles.getTile(letter: "F"))
            bag.append(scrabbleTiles.getTile(letter: "H"))
            bag.append(scrabbleTiles.getTile(letter: "M"))
            bag.append(scrabbleTiles.getTile(letter: "P"))
            bag.append(scrabbleTiles.getTile(letter: "V"))
            bag.append(scrabbleTiles.getTile(letter: "W"))
            bag.append(scrabbleTiles.getTile(letter: "Y"))
        }
        // generate D, L, S, and U tiles
        for _ in 0..<4 {
            bag.append(scrabbleTiles.getTile(letter: "D"))
            bag.append(scrabbleTiles.getTile(letter: "L"))
            bag.append(scrabbleTiles.getTile(letter: "S"))
            bag.append(scrabbleTiles.getTile(letter: "U"))
        }
        // generate E tiles
        for _ in 0..<12 {
            bag.append(scrabbleTiles.getTile(letter: "E"))
        }
        // generate G tiles
        for _ in 0..<3 {
            bag.append(scrabbleTiles.getTile(letter: "G"))
        }
        // generate N, R, and T tiles
        for _ in 0..<6 {
            bag.append(scrabbleTiles.getTile(letter: "N"))
            bag.append(scrabbleTiles.getTile(letter: "R"))
            bag.append(scrabbleTiles.getTile(letter: "T"))
        }
        // generate O tiles
        for _ in 0..<8 {
            bag.append(scrabbleTiles.getTile(letter: "O"))
        }
        // generate J, K, Q, X, and Z
        bag.append(scrabbleTiles.getTile(letter: "J"))
        bag.append(scrabbleTiles.getTile(letter: "K"))
        bag.append(scrabbleTiles.getTile(letter: "Q"))
        bag.append(scrabbleTiles.getTile(letter: "X"))
        bag.append(scrabbleTiles.getTile(letter: "Z"))
        
        // check that we should 98 tiles
        assert(bag.count == 98)
    }
    
    private mutating func pickTileFromBag() -> ScrabbleTile {
        // randomly pick a tile in the bag
        if let tile = bag.randomElement() {
            // remove the tiile from the bag
            if let index = bag.firstIndex(where: { $0.letter == tile.letter }) {
                bag.remove(at: index)
            }
            return tile
        }
        // return a nonsense tile if something goes wrong
        return ScrabbleTile(letter: "####", pointValue: 0)
    }
    
    public mutating func getPlayerTiles() {
        // clear any existing player tiles
        playerTiles.removeAll()
        // get the appropriate number of player tiles
        for _ in 0..<numberOfPlayerTiles {
            playerTiles.append(pickTileFromBag())
        }
        // put the player tile letters in the rack
        setRack()
    }
    
    private mutating func setRack() {
        // clear any existing letters in the rack
        rack.removeAll()
        // put the player tile letters in the rack
        for tile in playerTiles {
            rack.append(tile.letter.lowercased())
        }
    }
    
    private func calcWordPoints(for word: String) -> Int {
        var pointValue = 0
        // loop through the word to calculate the total points
        for letter in word {
            pointValue += scrabbleTiles.getTile(letter: String(letter.uppercased())).pointValue
        }
        return pointValue
    }
    
    public mutating func findWordMatches() {
        // check searchGroup words against dictionary words
        matchedWords.removeAll()
        for word in searchGroup {
            // if word is found in the dictionary, add the word to the matched collection
            if dictionary.contains(word) {
                matchedWords.append((word, calcWordPoints(for: word)))
            }
        }
    }
    
    public mutating func createSearchGroup() {
        // building groupings and permutations
        // start with 2-letters and move thtough to 7-letters
        for i in 2...rack.count {
            let size = i
            if let groupings = buildGroupings(ofSize: size, for: rack) {
                for group in groupings {
                    let perms = Array(group).permutations(xs: Array(group))
                    for perm in perms {
                        searchGroup.insert(String(perm))
                    }
                }
            }
        }
    }
    
    private func buildGroupings(ofSize size: Int, for stringArray: [String]) -> [String]? {
        guard size <= stringArray.count, size > 1, stringArray.count > 1, stringArray.count <= 7 else { return nil }
        var result: [String] = []
        // extend the rack to handle wrapping back to beginning to form the later groupings
        var extendedRack = stringArray
        for i in 0..<(size - 1) {
            extendedRack.append(stringArray[i])
        }
        // calculate the upper limit to loop through the extended rack
        let length = extendedRack.count - size + 1
        for i in 0..<(length) {
            switch size {
            case 2: // 2-letter groups
                result.append(extendedRack[i] + extendedRack[i + 1])
            case 3: // 3-letter groups
                result.append(extendedRack[i] + extendedRack[i + 1] + extendedRack[i + 2])
            case 4: // 4-letter groups
                result.append(extendedRack[i] + extendedRack[i + 1] + extendedRack[i + 2] + extendedRack[i + 3])
            case 5: // 5-letter groups
                result.append(extendedRack[i] + extendedRack[i + 1] + extendedRack[i + 2] + extendedRack[i + 3] + extendedRack[i + 4])
            case 6: // 6-letter groups
                result.append(extendedRack[i] + extendedRack[i + 1] + extendedRack[i + 2] + extendedRack[i + 3] + extendedRack[i + 4] + extendedRack[i + 5])
            default: // 7-letter groups
                result = [stringArray.joined()]
            }
        }
        return result
    }
}
