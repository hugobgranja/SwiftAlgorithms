//
//  IndexedPriorityQueueTests.swift
//  Created by hg on 14/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class IndexedPriorityQueueTests: XCTestCase {
    
    var sut: IndexedPriorityQueue<String>!
    
    override func setUp() {
        super.setUp()
        sut = IndexedPriorityQueue(length: 10, isLowerPriority: { $0 > $1 })
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testEnqueue() {
        addTestData()
        XCTAssertEqual(sut.size(), 3)
    }
    
    func testDequeue() {
        XCTAssertNil(sut.dequeue())
        addTestData()
        assertPairsEqual(sut.dequeue(), (1, "One"))
    }
    
    func testPeekIndex() {
        XCTAssertNil(sut.peekIndex())
        addTestData()
        XCTAssertEqual(sut.peekIndex(), 1)
    }
    
    func testPeekKey() {
        XCTAssertNil(sut.peekKey())
        addTestData()
        XCTAssertEqual(sut.peekKey(), "One")
    }
    
    func testIsEmpty() {
        XCTAssertTrue(sut.isEmpty())
        
        addTestData()
        XCTAssertFalse(sut.isEmpty())
        
        removeTestData()
        XCTAssertTrue(sut.isEmpty())
    }
    
    func testSize() {
        XCTAssertEqual(sut.size(), 0)
        
        _ = sut.dequeue()
        XCTAssertEqual(sut.size(), 0)
        
        addTestData()
        XCTAssertEqual(sut.size(), 3)
        
        _ = sut.dequeue()
        XCTAssertEqual(sut.size(), 2)
    }
    
    func testContains() {
        XCTAssertFalse(sut.contains(index: 0))
        addTestData()
        XCTAssertTrue(sut.contains(index: 0))
    }
    
    func testKeyOfIndex() {
        addTestData()
        XCTAssertEqual(sut.key(of: 0), "Zero")
    }
    
    func testChangeKey() {
        addTestData()
        sut.changeKey(index: 1, key: "OneTwo")
        assertPairsEqual(sut.dequeue(), (1, "OneTwo"))
    }
    
    func testDecreaseKey() {
        addTestData()
        sut.decreaseKey(index: 1, key: "Four")
        assertPairsEqual(sut.dequeue(), (1, "Four"))
    }
    
    func testIncreaseKey() {
        addTestData()
        sut.increaseKey(index: 1, key: "Three")
        assertPairsEqual(sut.dequeue(), (1, "Three"))
    }
    
    func testDelete() {
        addTestData()
        sut.delete(index: 1)
        XCTAssertEqual(sut.size(), 2)
        assertPairsEqual(sut.dequeue(), (2, "Two"))
    }
    
}

extension IndexedPriorityQueueTests {
    
    func addTestData() {
        sut.enqueue(index: 0, key: "Zero")
        sut.enqueue(index: 1, key: "One")
        sut.enqueue(index: 2, key: "Two")
    }
    
    func removeTestData() {
        sut.delete(index: 0)
        sut.delete(index: 1)
        sut.delete(index: 2)
    }
    
    func assertPairsEqual<T: Equatable, U: Equatable>(
        _ a: (T, U)?,
        _ b: (T, U),
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(a?.0, b.0, file: file, line: line)
        XCTAssertEqual(a?.1, b.1, file: file, line: line)
    }
    
}
