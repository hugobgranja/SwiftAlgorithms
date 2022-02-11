//
//  MinBinaryHeapTests.swift
//  Created by hg on 14/02/2022.
//

import XCTest
@testable import SwiftAlgorithms

class MinBinaryHeapTests: XCTestCase {
    
    var sut: MinBinaryHeap<Int>!
    
    override func setUp() {
        super.setUp()
        sut = MinBinaryHeap()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testEnqueue() {
        sut.enqueue(1)
        XCTAssertEqual(sut.size(), 1)
    }
    
    func testDequeue() {
        XCTAssertNil(sut.dequeue())
        
        sut.enqueue(1)
        XCTAssertEqual(sut.dequeue(), 1)
    }
    
    func testPeek() {
        XCTAssertNil(sut.peek())
        
        sut.enqueue(1)
        XCTAssertEqual(sut.peek(), 1)
    }
    
    func testIsEmpty() {
        XCTAssertTrue(sut.isEmpty())
        
        sut.enqueue(1)
        XCTAssertFalse(sut.isEmpty())
        
        _ = sut.dequeue()
        XCTAssertTrue(sut.isEmpty())
    }
    
    func testSize() {
        XCTAssertEqual(sut.size(), 0)
        
        _ = sut.dequeue()
        XCTAssertEqual(sut.size(), 0)
        
        sut.enqueue(1)
        XCTAssertEqual(sut.size(), 1)
        
        sut.enqueue(2)
        XCTAssertEqual(sut.size(), 2)
        
        _ = sut.dequeue()
        XCTAssertEqual(sut.size(), 1)
    }
    
    func testDequeueMany() {
        let elements = [20,19,18,14,16,15,1,5,9,7,8]
        
        for element in elements { sut.enqueue(element) }
        
        let sortedElements = elements.sorted { $0 < $1 }
        
        for element in sortedElements {
            XCTAssertEqual(sut.dequeue(), element)
        }
    }
    
}
