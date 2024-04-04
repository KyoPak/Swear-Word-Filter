import XCTest
@testable import SwearWordFilter

final class SwearWordContainerTests: XCTestCase {
    let container: SwearWordsContainer = DefaultSwearWordsContainer()
    
    // Test Constainer insert() Method
    /// This test code checks the logic of the insert method.

    func test_insert() {
        let addText = "KYO"
        container.insert(addText)
        
        XCTAssertTrue(container.getAllSwearWords().contains(addText))
    }
    
    // Test Constainer containsSwearWord(text:) Method
    /// This test code can check whether the swear word is included or not.
    func test_containsSwearWord() {
        // given
        let addText = "KYO"
        let notSwearText = "iOS"
        
        // when
        container.insert(addText)
        
        // then
        XCTAssertTrue(container.containsSwearWord(text: "씨발"))
        XCTAssertFalse(container.containsSwearWord(text: notSwearText))
    }
    
    /// This test code can be checked to see if the swear word is partially included.
    func test_containsSwearWord_Text_contain_SwearWord() {
        // ginve
        let addText = "KYO"
        let expectSwearText = "KYO iOS"
        
        // when
        container.insert(addText)
        
        // then
        XCTAssertTrue(container.containsSwearWord(text: addText))
        XCTAssertTrue(container.containsSwearWord(text: expectSwearText))
    }
    
    // Test Constainer remove(_:) Method
    /// This test code can check that certain words have been removed from the swear word list.
    func test_remove() {
        // given
        let addText = "KYO"
        container.insert(addText)
        
        // when
        XCTAssertTrue(container.containsSwearWord(text: addText))
        container.remove(addText)
        
        // then
        XCTAssertFalse(container.containsSwearWord(text: addText))
    }
    
    func test_current_SwearWordCount() {
        // given
        let originCount = container.getAllSwearWords().count
        
        // when
        container.insert("KYO")
        container.insert("iOS")
        container.insert("KYO")
        
        // then
        let afterCount = container.getAllSwearWords().count
        XCTAssertEqual(afterCount - originCount, 2)
    }
}
