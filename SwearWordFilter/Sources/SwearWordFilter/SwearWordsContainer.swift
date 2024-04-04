//
//  SwearWordsContainer.swift
//
//
//  Created by 박효성 on 4/4/24.
//

import Foundation

protocol SwearWordsContainer {
    func insert(_ word: String)
    func containsSwearWord(text: String) -> Bool
}

final class DefaultSwearWordsContainer: SwearWordsContainer {
    
    let root = TrieNode()
    
    init() {
        var words = (try? readTextFile()) ?? []
        words.forEach { insert($0) }
    }
    
    func insert(_ word: String) {
        var node = root
        for char in word {
            if node.children[char] == nil {
                node.children[char] = TrieNode()
            }
            
            node = node.children[char] ?? TrieNode()
        }
        node.isEndOfWord = true
    }
    
    func containsSwearWord(text: String) -> Bool {
        var node = root
        
        for i in 0..<text.count {
            var currentNode = node
            var j = i
            while j < text.count, let childNode = currentNode.children[text[text.index(text.startIndex, offsetBy: j)]] {
                currentNode = childNode
                if currentNode.isEndOfWord {
                    return true
                }
                
                j += 1
            }
        }
        
        return false
    }
}

enum FileError: Error {
    case fileMissing
    case fileReadInvalid
}

extension DefaultSwearWordsContainer {
    private enum Files {
        static let swearWordList = "SwearWordList"
        static let wordListType = "txt"
    }
    
    private func readTextFile() throws -> [String] {
        guard let paths = Bundle.module.path(forResource: Files.swearWordList, ofType: Files.wordListType) else {
            throw FileError.fileMissing
        }
        
        do {
            let contents = try String(contentsOfFile: paths, encoding: String.Encoding.utf8)
            let strings = contents.components(separatedBy: .newlines)
            let nonEmptyStrings = strings.filter { !$0.isEmpty }
            
            return nonEmptyStrings
        } catch {
            throw FileError.fileReadInvalid
        }
    }
}
