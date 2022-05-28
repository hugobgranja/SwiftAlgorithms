//
//  TSTTests.swift
//  Created by hg on 19/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class TSTTests: XCTestCase {
    
    var sut: TST<Int>!
    
    override func setUp() {
        super.setUp()
        sut = TST()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testInsert() {
        sut.insert(key: "Hello", value: 0)
        XCTAssertTrue(sut.count == 1)
    }
    
    func testContains() {
        XCTAssertFalse(sut.contains(key: "she"))
        addTestData()
        XCTAssertTrue(sut.contains(key: "she"))
        XCTAssertTrue(sut.contains(key: "seashells"))
        XCTAssertTrue(sut.contains(key: "surely"))
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
    
    func testLongestPrefix() {
        addTestData()
        let longestPrefix = sut.longestPrefix(of: "shoreline")
        XCTAssertEqual(longestPrefix, "shore")
    }
    
    func testLongestPrefixWhenMax() {
        addTestData()
        let longestPrefix = sut.longestPrefix(of: "seashells")
        XCTAssertEqual(longestPrefix, "seashells")
    }
    
    func testLongestPrefixWhenNotExists() {
        addTestData()
        let longestPrefix = sut.longestPrefix(of: "xyz")
        XCTAssertEqual(longestPrefix, "")
    }
    
    func testKeys() {
        addTestData()
        let expected = [
            "are", "by", "sea",
            "seashells", "sells", "she",
            "sheashells", "shells", "shore",
            "surely", "the"
        ]
        XCTAssertEqual(expected, sut.keys())
    }
    
    func testPrefixedBy() {
        addTestData()
        let prefixed = sut.prefixed(by: "she")
        let expected = ["she", "sheashells", "shells"]
        XCTAssertEqual(prefixed, expected)
    }

}

extension TSTTests {
    
    func addTestData() {
        let array = [
            "she", "sells", "seashells",
            "by", "the", "sea",
            "shore", "the", "shells",
            "she", "sells", "are",
            "surely", "sheashells"
        ]
        
        for (index, str) in array.enumerated() {
            sut.insert(key: str, value: index)
        }
    }
    
}
