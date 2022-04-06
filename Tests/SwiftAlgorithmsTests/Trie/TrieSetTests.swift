//
//  TrieSetTests.swift
//  Created by hg on 05/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class TrieSetTests: XCTestCase {
    
    var sut: TrieSet!
    
    override func setUp() {
        super.setUp()
        sut = TrieSet()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testInsert() {
        sut.insert("Hello")
        XCTAssertTrue(sut.count == 1)
    }
    
    func testContains() {
        XCTAssertFalse(sut.contains("she"))
        addTestData()
        XCTAssertTrue(sut.contains("she"))
        XCTAssertTrue(sut.contains("seashells"))
        XCTAssertTrue(sut.contains("surely"))
    }
    
    func testCount() {
        XCTAssertEqual(sut.count, 0)
        addTestData()
        XCTAssertEqual(sut.count, 11)
    }
    
    func testIsEmpty() {
        XCTAssertTrue(sut.isEmpty())
        addTestData()
        XCTAssertFalse(sut.isEmpty())
    }
    
    func testPrefixedBy() {
        addTestData()
        let prefixed = sut.prefixed(by: "she")
        let expected = ["she", "shells", "sheashells"]
        XCTAssertEqual(prefixed, expected)
    }
    
    func testLongestPrefix() {
        addTestData()
        let longestPrefix = sut.longestPrefix(of: "shoreline")
        XCTAssertEqual(longestPrefix, "shore")
    }

}

extension TrieSetTests {
    
    func addTestData() {
        let array = [
            "she", "sells", "seashells",
            "by", "the", "sea",
            "shore", "the", "shells",
            "she", "sells", "are",
            "surely", "sheashells"
        ]
        
        for str in array {
            sut.insert(str)
        }
    }
    
}
