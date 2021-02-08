//
//  LLRBTTests.swift
//  Created by hg on 31/12/2020.
//

import XCTest
@testable import SwiftAlgorithms

final class LLRBTTests: XCTestCase {
    
    var bst: LLRBT<Int, String>!
    
    override func setUp() {
        super.setUp()
        bst = LLRBT()
    }
    
    override func tearDown() {
        super.tearDown()
        bst = nil
    }
    
    func testPutAtRoot() {
        bst.put(key: 5, value: "Five")
        XCTAssertEqual(bst.get(key: 5), "Five")
    }
    
    func testPutMultiple() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        XCTAssertEqual(bst.get(key: 5), "Five")
        XCTAssertEqual(bst.get(key: 2), "Two")
        XCTAssertEqual(bst.get(key: 10), "Ten")
    }
    
    func testMax() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        XCTAssertEqual(bst.max(), 12)
    }
    
    func testMin() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        XCTAssertEqual(bst.min(), 0)
    }
    
    func testFloor() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        XCTAssertEqual(bst.floor(key: 6), 5)
    }
    
    func testCeiling() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        XCTAssertEqual(bst.ceiling(key: 9), 10)
    }
    
    func testSelect() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        
        let ordered = [0,2,4,5,10,12]
        for (index, element) in ordered.enumerated() {
            XCTAssertEqual(bst.select(rank: index), element)
        }
    }
    
    func testRank() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        
        let ordered = [0,2,4,5,10,12]
        for (index, element) in ordered.enumerated() {
            XCTAssertEqual(bst.rank(key: element), index)
        }
    }
    
    func testInorderIterator() {
        let values = [5,6,7,8,21,2,1,12]
        values.forEach { bst.put(key: $0, value: String($0)) }
        let it = LLRBTInorderIterator<Int, String>(bst)
        
        var keys = [Int]()
        while let key = it.next() { keys.append(key) }
        
        XCTAssertEqual(keys, values.sorted())
    }
    
    func testPreorderIterator() {
        let values = [5,6,7,8,21,2,1,12]
        values.forEach { bst.put(key: $0, value: String($0)) }
        let it = LLRBTPreorderIterator<Int, String>(bst)
        
        var keys = [Int]()
        while let key = it.next() { keys.append(key) }
        
        XCTAssertEqual(keys, [6,2,1,5,8,7,21,12])
    }
    
    func testPostorderIterator() {
        let values = [5,6,7,8,21,2,1,12]
        values.forEach { bst.put(key: $0, value: String($0)) }
        let it = LLRBTPostorderIterator<Int, String>(bst)
        
        var keys = [Int]()
        while let key = it.next() { keys.append(key) }
        
        XCTAssertEqual(keys, [1,5,2,7,12,21,8,6])
    }
    
    func testLevelIterator() {
        let values = [5,6,7,8,21,2,1,12]
        values.forEach { bst.put(key: $0, value: String($0)) }
        let it = LLRBTLevelIterator<Int, String>(bst)
        
        var keys = [Int]()
        while let key = it.next() { keys.append(key) }
        
        XCTAssertEqual(keys, [6,2,8,1,5,7,21,12])
    }
    
    func testDeleteMin() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        bst.deleteMin()
        XCTAssertEqual(bst.get(key: 0), nil)
    }
    
    // Delete node with no children
    func testDeleteCase0() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        bst.delete(key: 0)
        XCTAssertEqual(bst.get(key: 0), nil)
    }
    
    // Delete node with left child
    func testDeleteCase1() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 3, value: "Three")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        bst.delete(key: 4)
        XCTAssertEqual(bst.get(key: 4), nil)
        XCTAssertEqual(bst.get(key: 3), "Three")
    }
    
    // Delete node with left and right child
    func testDeleteCase2() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        bst.delete(key: 2)
        XCTAssertEqual(bst.get(key: 2), nil)
        XCTAssertEqual(bst.get(key: 4), "Four")
        XCTAssertEqual(bst.get(key: 0), "Zero")
    }
    
    func testKeys() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        
        let orderedKeys = [0,2,4,5,10,12]
        XCTAssertEqual(orderedKeys, bst.keys())
    }
    
    func testLLRBT() {
        let size = 1000
        
        for _ in 0..<size {
            let randomNumber = Int.random(in: 0...10000)
            bst.put(key: randomNumber, value: String(randomNumber))
            XCTAssertTrue(bst.isBST())
            XCTAssertTrue(bst.isSizeConsistent())
            bst.keys().enumerated().forEach { XCTAssertEqual(bst.rank(key: $1), $0) }
            XCTAssertTrue(bst.is23())
            XCTAssertTrue(bst.isBalanced())
        }
        
        for _ in 0..<size {
            if let key = bst.keys().randomElement() { bst.delete(key: key) }
            XCTAssertTrue(bst.isBST())
            XCTAssertTrue(bst.isSizeConsistent())
            bst.keys().enumerated().forEach { XCTAssertEqual(bst.rank(key: $1), $0) }
            XCTAssertTrue(bst.is23())
            XCTAssertTrue(bst.isBalanced())
        }
    }
    
    static var allTests = [
        ("testPutAtRoot", testPutAtRoot),
        ("testPutMultiple", testPutMultiple),
        ("testMax", testMax),
        ("testMin", testMin),
        ("testFloor", testFloor),
        ("testCeiling", testCeiling),
        ("testSelect", testSelect),
        ("testRank", testRank),
        ("testInorderIterator", testInorderIterator),
        ("testPreorderIterator", testPreorderIterator),
        ("testPostorderIterator", testPostorderIterator),
        ("testLevelIterator", testLevelIterator),
        ("testDeleteMin", testDeleteMin),
        ("testDeleteCase0", testDeleteCase0),
        ("testDeleteCase1", testDeleteCase1),
        ("testDeleteCase2", testDeleteCase2),
        ("testLLRBT", testLLRBT)
    ]
}
