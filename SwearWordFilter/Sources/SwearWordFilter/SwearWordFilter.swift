//
//  SwearWordFilter.swift
//
//
//  Created by 박효성 on 4/4/24.
//

import Foundation

/// User can Access thid Class.
public class SwearWordFilter {
    
    private let container: SwearWordsContainer
    
    /// Initializes the SwearWordFilter with a default container.
    init() {
        container = DefaultSwearWordsContainer()
    }
    
    /// Check text contains swear word.
    public func containSwearWord(_ text: String) -> Bool {
        return container.containsSwearWord(text: text)
    }
    
    /// Replace the swear word inside the text with a specific character.
    public func replaceSwearWord(_ text: String, withChar replaceCharacter: Character = "*") -> String {
        var filteredText = text
        container.getAllSwearWords().forEach { swearWord in
            let replaceText = String(repeating: replaceCharacter, count: swearWord.count)
            filteredText = filteredText.replacingOccurrences(of: swearWord, with: replaceText)
        }
        
        return filteredText
    }
    
    /// Replace the swear word inside the text with a specific text.
    public func replaceSwearWord(_ text: String, withString replaceText: String) -> String {
        var filteredText = text
        container.getAllSwearWords().forEach { swearWord in
            filteredText = filteredText.replacingOccurrences(of: swearWord, with: replaceText)
        }
        
        return filteredText
    }
    
    /// Add text in Origin swear word list.
    public func addSwearWord(_ text: String) {
        container.insert(text)
    }
    
    /// Add texts in Origin swear word list.
    public func addSwearWord(_ texts: [String]) {
        texts.forEach { container.insert($0) }
    }
    
    /// Remove text in Origin swear word list.
    public func removeSwearWord(_ text: String) {
        container.remove(text)
    }
    
    /// Remove texts in Origin swear word list.
    public func removeSwearWord(_ texts: [String]) {
        texts.forEach { container.remove($0) }
    }
}
