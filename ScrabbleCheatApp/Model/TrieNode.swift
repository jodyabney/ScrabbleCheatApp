//
//  TrieNode.swift
//  ScrabbleCheat
//
//  Created by Jody Abney on 6/3/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

// based on pages 200 - 211 in "Data Structures & Algorithms in Swift" book from raywenderlich.com

import Foundation

public class TrieNode<Key: Hashable> {
    
    public var key: Key?
    
    public weak var parent: TrieNode?
    
    public var children: [Key: TrieNode] = [:]
    
    public var isTerminating = false
    
    public init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
}
