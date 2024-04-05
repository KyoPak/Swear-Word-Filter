import XCTest
@testable import SwearWordFilter

final class SwearWordFilterTests: XCTestCase {
    let filterSW = SwearWordFilter()
    
    
    // Test Filter addSwearWord(_:), containSwearWord(_:) Method
    /// This test code checks the logic of the insert, contain method.
    func test_addContainNewSwearWord() {
        // given
        let addSwearWord = "KYO"
        let lowerSwearWord = "kyo"
        
        // when
        filterSW.addSwearWord(addSwearWord)
        
        // then
        XCTAssertTrue(filterSW.containSwearWord(addSwearWord))
        XCTAssertTrue(filterSW.containSwearWord(lowerSwearWord))
    }
    
    // Test Filter replaceSwearWord(_:) Method
    /// This test code checks the logic of the replace text mehod
    func test_replaceSwearWord() {
        // given
        let replaceText = "Hello KYO KY"
        let replaceCharactor: Character = "*"
        
        let addSwearWord = "KYO"
        let expectResult = "Hello *** KY"
        
        // when
        filterSW.addSwearWord(addSwearWord)
        
        // then
        print(filterSW.replaceSwearWord(replaceText, withChar: replaceCharactor))
        XCTAssertEqual(
            filterSW.replaceSwearWord(replaceText, withChar: replaceCharactor),
            expectResult
        )
    }
    
    // Test Filter removeSwearWord(_:) Method
    /// This test code checks the logic of the replace text mehod
    func test_removeSwearWord() {
        // given
        let swearWord = "KYO"
        filterSW.addSwearWord(swearWord)
        
        // when
        XCTAssertTrue(filterSW.containSwearWord(swearWord))
        filterSW.removeSwearWord(swearWord)
        
        XCTAssertFalse(filterSW.containSwearWord(swearWord))
    }
}
