//
//  BinarySearchTreeTests.swift
//  Created by hg on 31/12/2020.
//

import XCTest
@testable import SwiftAlgorithms

final class BinarySearchTreeTests: XCTestCase {
    
    var bst: BinarySearchTree<Int, String>!
    
    override func setUp() {
        super.setUp()
        bst = BinarySearchTree()
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
    
    func testRank() {
        bst.put(key: 5, value: "Five")
        bst.put(key: 2, value: "Two")
        bst.put(key: 10, value: "Ten")
        bst.put(key: 4, value: "Four")
        bst.put(key: 12, value: "Twelve")
        bst.put(key: 0, value: "Zero")
        XCTAssertEqual(bst.rank(key: 10), 4)
    }
    
    func testInorderIterator() {
        let values = [5,6,7,8,21,2,1,12]
        values.forEach { bst.put(key: $0, value: String($0)) }
        var it = BinarySearchTreeInorderIterator<Int, String>(bst)
        
        var inorderKeys = [Int]()
        while let key = it.next() { inorderKeys.append(key) }
        
        XCTAssertEqual(inorderKeys, values.sorted())
    }
    
    func testPreorderIterator() {
        let values = [5,6,7,8,21,2,1,12]
        values.forEach { bst.put(key: $0, value: String($0)) }
        var it = BinarySearchTreePreorderIterator<Int, String>(bst)
        
        var preorderKeys = [Int]()
        while let key = it.next() { preorderKeys.append(key) }
        
        XCTAssertEqual(preorderKeys, [5,2,1,6,7,8,21,12])
    }
    
    func testPostorderIterator() {
        let values = [5,6,7,8,21,2,1,12]
        values.forEach { bst.put(key: $0, value: String($0)) }
        var it = BinarySearchTreePostorderIterator<Int, String>(bst)
        
        var postorderKeys = [Int]()
        while let key = it.next() { postorderKeys.append(key) }
        
        XCTAssertEqual(postorderKeys, [1,2,12,21,8,7,6,5])
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
    
    static var allTests = [
        ("testPutAtRoot", testPutAtRoot),
        ("testPutMultiple", testPutMultiple),
        ("testMax", testMax),
        ("testMin", testMin),
        ("testFloor", testFloor),
        ("testCeiling", testCeiling),
        ("testInorderIterator", testInorderIterator),
        ("testPreorderIterator", testPreorderIterator),
        ("testPostorderIterator", testPostorderIterator),
        ("testDeleteMin", testDeleteMin),
        ("testDeleteCase0", testDeleteCase0),
        ("testDeleteCase1", testDeleteCase1),
        ("testDeleteCase2", testDeleteCase2)
    ]
}
