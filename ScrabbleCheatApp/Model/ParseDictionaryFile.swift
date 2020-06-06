//
//  ParseDictionaryFile.swift
//  ScrabbleCheat
//
//  Created by Jody Abney on 6/1/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct ParseDictionaryFile {
    
    static var shared = ParseDictionaryFile()
    
    static func readDictionary() -> [String] {
        
        if let filepath = Bundle.main.path(forResource: "dictionary", ofType: "txt") {
            if let dictionary = try? String(contentsOfFile: filepath) {
                let allWords = dictionary.components(separatedBy: CharacterSet.newlines)
                return allWords
            }
        }
        print("no file read")
        return [String()]
    }
}


