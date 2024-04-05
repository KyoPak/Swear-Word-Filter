//
//  TrieNode.swift
//
//
//  Created by 박효성 on 4/4/24.
//

import Foundation

final class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isEndOfWord: Bool = false
}
