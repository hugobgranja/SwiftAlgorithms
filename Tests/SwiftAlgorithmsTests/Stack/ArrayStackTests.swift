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
        XCTAssertTrue(isEqual(stack: sut, array: array))
    }
    
    func testPush() {
        sut.push(1)
        XCTAssertEqual(sut.size(), 1)
    }
    
    func testPushArray() {
        let array = [1,2,3,4,5]
        sut.push(contentsOf: array)
        XCTAssertTrue(isEqual(stack: sut, array: array))
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
        XCTAssertEqual(sut.size(), 0)
        
        _ = sut.pop()
        XCTAssertEqual(sut.size(), 0)
        
        sut.push(1)
        XCTAssertEqual(sut.size(), 1)
        
        sut.push(2)
        XCTAssertEqual(sut.size(), 2)
        
        _ = sut.pop()
        XCTAssertEqual(sut.size(), 1)
    }

}

extension ArrayStackTests {
    
    func isEqual<T: Equatable>(stack: ArrayStack<T>, array: [T]) -> Bool {
        var stackArray = [T]()
        
        while let element = stack.pop() {
            stackArray.append(element)
        }
        
        return stackArray.reversed() == array
    }
    
}
