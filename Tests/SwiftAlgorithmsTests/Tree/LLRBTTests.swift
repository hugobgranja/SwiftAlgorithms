//
//  LLRBTTests.swift
//  Created by hg on 31/12/2020.
//

import XCTest
@testable import SwiftAlgorithms

class LLRBTTests: XCTestCase {
    
    let utils = TreeTestsUtils()
    var sut: LLRBT<Int, String>!
    
    override func setUp() {
        super.setUp()
        sut = LLRBT()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testGet() {
        XCTAssertNil(sut.get(key: 5))
        
        addTestData()
        XCTAssertEqual(sut.get(key: 5), "Five")
    }
    
    func testContains() {
        XCTAssertFalse(sut.contains(key: 5))
        
        addTestData()
        XCTAssertTrue(sut.contains(key: 5))
    }
    
    func testMax() {
        addTestData()
        XCTAssertEqual(sut.max()?.key, 12)
    }
    
    func testMin() {
        addTestData()
        XCTAssertEqual(sut.min()?.key, 0)
    }
    
    func testFloor() {
        addTestData()
        let key = sut.floor(key: 6)?.key
        XCTAssertEqual(key, 5)
    }
    
    func testCeiling() {
        addTestData()
        let key = sut.ceiling(key: 9)?.key
        XCTAssertEqual(key, 10)
    }
    
    func testSelect() {
        addTestData()
        
        let sorted = [0,2,3,4,5,10,12]
        
        for (index, element) in sorted.enumerated() {
            let key = sut.select(rank: index)?.key
            XCTAssertEqual(key, element)
        }
    }
    
    func testRank() {
        addTestData()
        
        let sorted = [0,2,3,4,5,10,12]
        
        for (index, element) in sorted.enumerated() {
            XCTAssertEqual(sut.rank(key: element), index)
        }
    }
    
    func testDeleteMin() {
        addTestData()
        sut.deleteMin()
        XCTAssertEqual(sut.get(key: 0), nil)
    }
    
    // Delete node with no children
    func testDeleteCase0() {
        addTestData()
        sut.delete(key: 0)
        XCTAssertEqual(sut.get(key: 0), nil)
    }
    
    // Delete node with left child
    func testDeleteCase1() {
        addTestData()
        sut.delete(key: 4)
        XCTAssertEqual(sut.get(key: 4), nil)
        XCTAssertEqual(sut.get(key: 3), "Three")
    }
    
    // Delete node with left and right child
    func testDeleteCase2() {
        addTestData()
        sut.delete(key: 2)
        XCTAssertEqual(sut.get(key: 2), nil)
        XCTAssertEqual(sut.get(key: 4), "Four")
        XCTAssertEqual(sut.get(key: 0), "Zero")
    }
    
    func testKeys() {
        addTestData()
        let keys = [0,2,3,4,5,10,12]
        XCTAssertEqual(keys, sut.keys())
    }
    
    func testSizeRange() {
        addTestData()
        
        var size = sut.size(low: 2, high: 5)
        XCTAssertEqual(size, 4)
        
        size = sut.size(low: 4, high: 11)
        XCTAssertEqual(size, 3)
        
        size = sut.size(low: 0, high: 0)
        XCTAssertEqual(size, 1)
        
        size = sut.size(low: 14, high: 19)
        XCTAssertEqual(size, 0)
    }
    
    func testRangeSearch() {
        addTestData()
        
        var range = sut.rangeSearch(low: 2, high: 5).map { $0.key }
        XCTAssertEqual(range, [2,3,4,5])
        
        range = sut.rangeSearch(low: 4, high: 11).map { $0.key }
        XCTAssertEqual(range, [4,5,10])
        
        range = sut.rangeSearch(low: 0, high: 0).map { $0.key }
        XCTAssertEqual(range, [0])
        
        range = sut.rangeSearch(low: 14, high: 19).map { $0.key }
        XCTAssertEqual(range, [])
    }
    
    func testInorderIterator() {
        addTestData()
        
        let it = LLRBTInorderIterator<Int, String>(sut)
        
        let expectation = [
            (0, "Zero"),
            (2, "Two"),
            (3, "Three"),
            (4, "Four"),
            (5, "Five"),
            (10, "Ten"),
            (12, "Twelve"),
        ]
        
        var result = [(Int, String)]()
        while let kvp = it.next() { result.append(kvp) }
        
        utils.checkPairs(result: result, expectation: expectation)
    }
    
    func testPreorderIterator() {
        addTestData()
        
        let it = LLRBTPreorderIterator<Int, String>(sut)
        
        let expectation = [
            (5, "Five"),
            (3, "Three"),
            (2, "Two"),
            (0, "Zero"),
            (4, "Four"),
            (12, "Twelve"),
            (10, "Ten")
        ]
        
        var result = [(Int, String)]()
        while let kvp = it.next() { result.append(kvp) }
        
        utils.checkPairs(result: result, expectation: expectation)
    }
    
    func testPostorderIterator() {
        addTestData()
        
        let it = LLRBTPostorderIterator<Int, String>(sut)
        
        let expectation = [
            (0, "Zero"),
            (2, "Two"),
            (4, "Four"),
            (3, "Three"),
            (10, "Ten"),
            (12, "Twelve"),
            (5, "Five")
        ]
        
        var result = [(Int, String)]()
        while let kvp = it.next() { result.append(kvp) }
        
        utils.checkPairs(result: result, expectation: expectation)
    }
    
    func testLevelIterator() {
        addTestData()
        
        let it = LLRBTLevelIterator<Int, String>(sut)
        
        let expectation = [
            (5, "Five"),
            (3, "Three"),
            (12, "Twelve"),
            (2, "Two"),
            (4, "Four"),
            (10, "Ten"),
            (0, "Zero")
        ]
        
        var result = [(Int, String)]()
        while let kvp = it.next() { result.append(kvp) }
        
        utils.checkPairs(result: result, expectation: expectation)
    }
    
    func testLLRBT() {
        let size = 1000
        
        for _ in 0..<size {
            let randomNumber = Int.random(in: 0...10000)
            sut.put(key: randomNumber, value: String(randomNumber))
            XCTAssertTrue(sut.isBST())
            XCTAssertTrue(sut.isSizeConsistent())
            sut.keys().enumerated().forEach { XCTAssertEqual(sut.rank(key: $1), $0) }
            XCTAssertTrue(sut.is23())
            XCTAssertTrue(sut.isBalanced())
        }
        
        for _ in 0..<size {
            if let key = sut.keys().randomElement() { sut.delete(key: key) }
            XCTAssertTrue(sut.isBST())
            XCTAssertTrue(sut.isSizeConsistent())
            sut.keys().enumerated().forEach { XCTAssertEqual(sut.rank(key: $1), $0) }
            XCTAssertTrue(sut.is23())
            XCTAssertTrue(sut.isBalanced())
        }
    }
    
}

// Utility Methods
extension LLRBTTests {
    
    private func addTestData() {
        sut.put(key: 5, value: "Five")
        sut.put(key: 2, value: "Two")
        sut.put(key: 10, value: "Ten")
        sut.put(key: 4, value: "Four")
        sut.put(key: 3, value: "Three")
        sut.put(key: 12, value: "Twelve")
        sut.put(key: 0, value: "Zero")
    }
    
}
