//
//  SwearWordFilter.swift
//
//
//  Created by 박효성 on 4/4/24.
//

import Foundation

/// User can Access this Class.
/// 'SwearWordFilter' is only public class in thid Library.

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
        var filteredText = text.lowercased()
        
        container.getAllSwearWords().forEach { swearWord in
            let replaceText = String(repeating: replaceCharacter, count: swearWord.count)
            filteredText = filteredText.replacingOccurrences(of: swearWord, with: replaceText)
        }
        
        return syncOriginText(filteredText, text, replaceCharacter: replaceCharacter)
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

extension SwearWordFilter {
    /* Replace Text sync Origin Text
        If replaceCharacter is "#", swear word is iO,
        Origin Text : "Hello iO", Filter Text : "hello ##"
        Return "Hello ##"
    */
    
    private func syncOriginText(_ filterText: String, _ originText: String, replaceCharacter: Character) -> String {
        let originTexts = originText.map { String($0) }
        let filterTexts = filterText.map { String($0) }
        
        var syncText: [String] = []
        
        guard originTexts.count == filterTexts.count else { return filterText }
        
        for index in 0..<originTexts.count {
            let syncChar = filterTexts[index] != String(replaceCharacter) ? originTexts[index] : filterTexts[index]
            syncText.append(String(syncChar))
        }
        
        return syncText.joined()
    }
}
