//
//  TwoStackQueueTests.swift
//  Created by hg on 15/02/2022.
//

import XCTest
@testable import SwiftAlgorithms

class TwoStackQueueTests: XCTestCase {
    
    var sut: TwoStackQueue<Int>!
    
    override func setUp() {
        super.setUp()
        sut = TwoStackQueue()
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
        
        sut.enqueue(2)
        XCTAssertEqual(sut.peek(), 2)
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

}
