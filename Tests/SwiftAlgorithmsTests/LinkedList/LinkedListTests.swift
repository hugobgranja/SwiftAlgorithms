//
//  LinkedListTests.swift
//  Created by hg on 11/10/2020.
//

import XCTest
@testable import SwiftAlgorithms

class LinkedListTests: XCTestCase {
    
    var sut: SinglyLinkedList<Int>!
    
    override func setUp() {
        super.setUp()
        sut = SinglyLinkedList()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testAppend() {
        sut.append(1)
        sut.append(2)
        XCTAssertEqual(sut.removeFirst(), 1)
    }
    
    func testPrepend() {
        sut.prepend(1)
        sut.prepend(2)
        XCTAssertEqual(sut.removeFirst(), 2)
    }
    
    func testRemove() {
        XCTAssertNil(sut.removeFirst())
        
        sut.append(1)
        XCTAssertEqual(sut.removeFirst(), 1)
    }
    
    func testFirst() {
        XCTAssertNil(sut.first())
        
        sut.append(1)
        XCTAssertEqual(sut.first(), 1)
        
        sut.append(2)
        XCTAssertEqual(sut.first(), 1)
        
        sut.prepend(3)
        XCTAssertEqual(sut.first(), 3)
    }
    
    func testLast() {
        XCTAssertNil(sut.last())
        
        sut.append(1)
        XCTAssertEqual(sut.last(), 1)
        
        sut.prepend(2)
        XCTAssertEqual(sut.last(), 1)
        
        sut.append(4)
        XCTAssertEqual(sut.last(), 4)
    }
    
    func testIsEmpty() {
        XCTAssertTrue(sut.isEmpty())
        
        sut.append(1)
        XCTAssertFalse(sut.isEmpty())
        
        _ = sut.removeFirst()
        XCTAssertTrue(sut.isEmpty())
    }
    
    func testSize() {
        XCTAssertEqual(sut.size(), 0)
        
        _ = sut.removeFirst()
        XCTAssertEqual(sut.size(), 0)
        
        sut.append(1)
        XCTAssertEqual(sut.size(), 1)
        
        sut.prepend(2)
        XCTAssertEqual(sut.size(), 2)
        
        _ = sut.removeFirst()
        XCTAssertEqual(sut.size(), 1)
        
        _ = sut.removeFirst()
        XCTAssertEqual(sut.size(), 0)
    }

}

