//
//  SwearWordsContainer.swift
//
//
//  Created by 박효성 on 4/4/24.
//

import Foundation

/// 'DefaultSwearWordsContainer' is manage SwearWord Data using Trie Tree.

protocol SwearWordsContainer {
    func insert(_ word: String)
    func remove(_ word: String)
    func getAllSwearWords() -> [String]
    func containsSwearWord(text: String) -> Bool
}

final class DefaultSwearWordsContainer: SwearWordsContainer {
    
    private let root = TrieNode()
    private var swearWords: Set<String> = []
    
    init() {
        let words = (try? readTextFile()) ?? []
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
        swearWords.insert(word)
    }
    
    func containsSwearWord(text: String) -> Bool {
        for i in 0..<text.count {
            var currentNode = root
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
    
    func remove(_ word: String) {
        guard swearWords.contains(word) else { return }
        remove(root, word, index: word.startIndex)
        swearWords.remove(word)
    }
    
    func getAllSwearWords() -> [String] {
        return Array(swearWords)
    }
    
    private func remove(_ node: TrieNode, _ word: String, index: String.Index) {
        if index == word.endIndex {
            node.isEndOfWord = false
            return
        }
        
        if let child = node.children[word[index]] {
            remove(child, word, index: word.index(after: index))
            
            if !child.isEndOfWord && child.children.isEmpty {
                node.children.removeValue(forKey: word[index])
            }
        }
    }
}

// MARK: Files Path
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
