//
//  ArrayStackTests.swift
//  Created by hg on 12/10/2020.
//

import XCTest
@testable import SwiftAlgorithms

class ArrayStackTests: XCTestCase {
    
    var sut: ArrayStack<Int>!
    
    override func setUp() {
        super.setUp()
        sut = ArrayStack()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testInitArray() {
        let array = [1,2,3,4,5]
        let sut = ArrayStack(array)
        XCTAssertEqual(array, sut.elements)
    }
    
    func testPush() {
        sut.push(1)
        XCTAssertEqual(sut.count, 1)
    }
    
    func testPushArray() {
        let array = [1,2,3,4,5]
        sut.push(contentsOf: array)
        XCTAssertEqual(array, sut.elements)
    }
    
    func testPop() {
        XCTAssertNil(sut.pop())
        
        sut.push(1)
        XCTAssertEqual(sut.pop(), 1)
    }
    
    func testPeek() {
        XCTAssertNil(sut.peek())
        
        sut.push(2)
        XCTAssertEqual(sut.peek(), 2)
    }
    
    func testIsEmpty() {
        XCTAssertTrue(sut.isEmpty())
        
        sut.push(1)
        XCTAssertFalse(sut.isEmpty())
        
        _ = sut.pop()
        XCTAssertTrue(sut.isEmpty())
    }
    
    func testSize() {
        XCTAssertEqual(sut.count, 0)
        
        _ = sut.pop()
        XCTAssertEqual(sut.count, 0)
        
        sut.push(1)
        XCTAssertEqual(sut.count, 1)
        
        sut.push(2)
        XCTAssertEqual(sut.count, 2)
        
        _ = sut.pop()
        XCTAssertEqual(sut.count, 1)
    }

}
