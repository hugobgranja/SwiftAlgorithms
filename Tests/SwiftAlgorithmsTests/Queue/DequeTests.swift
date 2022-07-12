//
//  Deque.swift
//  Created by hg on 12/07/2022.
//

import XCTest
@testable import SwiftAlgorithms

class DequeTests: XCTestCase {
    
    var sut: Deque<Int>!
    
    override func setUp() {
        super.setUp()
        sut = Deque(capacity: 5)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testAppend() {
        sut.append(0)
        XCTAssertTrue(sut.count == 1)
    }
    
    func testAppendWrap() {
        sut.append(0)
        sut.append(1)
        sut.append(2)
        sut.append(3)
        sut.append(4)
        sut.popFirst()
        sut.append(5)
        XCTAssertEqual(sut.first, 1)
        XCTAssertEqual(sut.last, 5)
    }
    
    func testPrepend() {
        sut.prepend(0)
        XCTAssertTrue(sut.count == 1)
    }
    
    func testPrependWrap() {
        sut.append(0)
        sut.append(1)
        sut.append(2)
        sut.prepend(3)
        XCTAssertEqual(sut.first, 3)
        XCTAssertEqual(sut.last, 2)
    }
    
    func testFirst() {
        sut.append(0)
        sut.append(1)
        XCTAssertEqual(sut.first, 0)
    }
    
    func testLast() {
        sut.append(0)
        sut.append(1)
        XCTAssertEqual(sut.last, 1)
    }
    
    func testPopFirstWhenEmpty() {
        XCTAssertNil(sut.popFirst())
    }
    
    func testPopFirst() {
        sut.append(0)
        sut.append(1)
        XCTAssertEqual(sut.popFirst(), 0)
    }
    
    func testPopFirstWrap() {
        sut.append(0)
        sut.append(1)
        sut.append(2)
        sut.prepend(3)
        XCTAssertEqual(sut.popFirst(), 3)
        XCTAssertEqual(sut.popFirst(), 0)
    }
    
    func testPopLastWhenEmpty() {
        XCTAssertNil(sut.popLast())
    }
    
    func testPopLast() {
        sut.append(0)
        sut.append(1)
        XCTAssertEqual(sut.popLast(), 1)
    }
    
    func testPopLastWrap() {
        sut.append(0)
        sut.append(1)
        sut.append(2)
        sut.append(3)
        sut.append(4)
        sut.popFirst()
        sut.append(5)
        XCTAssertEqual(sut.popLast(), 5)
        XCTAssertEqual(sut.popLast(), 4)
    }
    
    func testSequence() {
        let values = [0,1,2,3,4]
        
        for value in values { sut.append(value) }
        
        for value in values {
            sut.popFirst()
            sut.append(value + 5)
        }
        
        let expected = [5,6,7,8,9]
        for (index, elem) in sut.enumerated() {
            XCTAssertEqual(elem, expected[index])
        }
    }
    
}

