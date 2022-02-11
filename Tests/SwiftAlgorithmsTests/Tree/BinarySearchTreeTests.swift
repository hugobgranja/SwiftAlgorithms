//
//  BinarySearchTreeTests.swift
//  Created by hg on 31/12/2020.
//

import XCTest
@testable import SwiftAlgorithms

class BinarySearchTreeTests: XCTestCase {
    
    let utils = TreeTestsUtils()
    var sut: BinarySearchTreeImpl<Int, String>!
    
    override func setUp() {
        super.setUp()
        sut = BinarySearchTreeImpl()
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
        
        let expectation = [0,2,3,4,5,10,12]
        
        for (index, element) in expectation.enumerated() {
            let key = sut.select(rank: index)?.key
            XCTAssertEqual(key, element)
        }
    }
    
    func testRank() {
        addTestData()
        
        let expectation = [0,2,3,4,5,10,12]
        
        for (index, element) in expectation.enumerated() {
            XCTAssertEqual(sut.rank(key: element), index)
        }
    }
    
    func testDeleteMin() {
        addTestData()
        sut.deleteMin()
        XCTAssertNil(sut.get(key: 0))
    }
    
    func testDeleteMax() {
        addTestData()
        sut.deleteMax()
        XCTAssertNil(sut.get(key: 12))
    }
    
    // Delete node with no children
    func testDeleteCase0() {
        addTestData()
        sut.delete(key: 0)
        XCTAssertNil(sut.get(key: 0))
    }
    
    // Delete node with left child
    func testDeleteCase1() {
        addTestData()
        sut.delete(key: 4)
        XCTAssertNil(sut.get(key: 4))
        XCTAssertEqual(sut.get(key: 3), "Three")
    }
    
    // Delete node with left and right child
    func testDeleteCase2() {
        addTestData()
        sut.delete(key: 2)
        XCTAssertNil(sut.get(key: 2))
        XCTAssertEqual(sut.get(key: 4), "Four")
        XCTAssertEqual(sut.get(key: 0), "Zero")
    }
    
    func testSize() {
        XCTAssertEqual(sut.size(), 0)
        
        addTestData()
        XCTAssertEqual(sut.size(), 7)
    }
    
    func testIsEmpty() {
        XCTAssertTrue(sut.isEmpty())
        
        addTestData()
        XCTAssertFalse(sut.isEmpty())
    }
    
    func testKeys() {
        addTestData()
        let keys = sut.keys()
        XCTAssertEqual(keys, [0,2,3,4,5,10,12])
    }
    
    func testInorderIterator() {
        addTestData()
        
        let it = BSTInorderIterator<Int, String>(sut)
        
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
        
        let it = BSTPreorderIterator<Int, String>(sut)
        
        let expectation = [
            (5, "Five"),
            (2, "Two"),
            (0, "Zero"),
            (4, "Four"),
            (3, "Three"),
            (10, "Ten"),
            (12, "Twelve"),
        ]
        
        var result = [(Int, String)]()
        while let kvp = it.next() { result.append(kvp) }
        
        utils.checkPairs(result: result, expectation: expectation)
    }
    
    func testPostorderIterator() {
        addTestData()
        
        let it = BSTPostorderIterator<Int, String>(sut)
        
        let expectation = [
            (0, "Zero"),
            (3, "Three"),
            (4, "Four"),
            (2, "Two"),
            (12, "Twelve"),
            (10, "Ten"),
            (5, "Five"),
        ]
        
        var result = [(Int, String)]()
        while let kvp = it.next() { result.append(kvp) }
        
        utils.checkPairs(result: result, expectation: expectation)
    }
    
    func testLevelIterator() {
        addTestData()
        
        let it = BSTLevelIterator<Int, String>(sut)
        
        let expectation = [
            (5, "Five"),
            (2, "Two"),
            (10, "Ten"),
            (0, "Zero"),
            (4, "Four"),
            (12, "Twelve"),
            (3, "Three"),
        ]
        
        var result = [(Int, String)]()
        while let kvp = it.next() { result.append(kvp) }
        
        utils.checkPairs(result: result, expectation: expectation)
    }
    
}

// Utility Methods
extension BinarySearchTreeTests {
    
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
