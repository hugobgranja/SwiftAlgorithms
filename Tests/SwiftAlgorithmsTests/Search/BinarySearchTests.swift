//
//  BinarySearchTests.swift
//  Created by hg on 18/10/2020.
//

import XCTest
@testable import SwiftAlgorithms

class BinarySearchTests: XCTestCase {
    
    var sut: BinarySearch!
    
    override func setUp() {
        super.setUp()
        sut = BinarySearch()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testSearchWhenIsEmpty() {
        let array = [Int]()
        let index = sut.indexOf(array, 1)
        let indexIt = sut.indexOfIt(array, 1)
        XCTAssertNil(index)
        XCTAssertNil(indexIt)
    }
    
    func testSearchWhenNotContains() {
        let array = [1,2,3,4,5,6,7,8,9]
        let index = sut.indexOf(array, 10)
        let indexIt = sut.indexOfIt(array, 10)
        XCTAssertNil(index)
        XCTAssertNil(indexIt)
    }
    
    func testSearchFirst() {
        let array = [1,2,3,4,5,6,7,8,9]
        let index = sut.indexOf(array, 1)
        let indexIt = sut.indexOfIt(array, 1)
        XCTAssertEqual(index, 0)
        XCTAssertEqual(indexIt, 0)
    }
    
    func testSearchLast() {
        let array = [1,2,3,4,5,6,7,8,9]
        let index = sut.indexOf(array, 9)
        let indexIt = sut.indexOfIt(array, 9)
        XCTAssertEqual(index, 8)
        XCTAssertEqual(indexIt, 8)
    }
    
    func testSearchMidEven() {
        let array = [1,2,3,4,5,6,7,8]
        var index = sut.indexOf(array, 4)
        var indexIt = sut.indexOfIt(array, 4)
        XCTAssertEqual(index, 3)
        XCTAssertEqual(indexIt, 3)
        
        index = sut.indexOf(array, 5)
        indexIt = sut.indexOfIt(array, 5)
        XCTAssertEqual(index, 4)
        XCTAssertEqual(indexIt, 4)
    }

    func testSearchMidOdd() {
        let array = [1,2,3,4,5,6,7,8,9]
        var index = sut.indexOf(array, 5)
        var indexIt = sut.indexOfIt(array, 5)
        XCTAssertEqual(index, 4)
        XCTAssertEqual(indexIt, 4)
        
        index = sut.indexOf(array, 6)
        indexIt = sut.indexOfIt(array, 6)
        XCTAssertEqual(index, 5)
        XCTAssertEqual(indexIt, 5)
    }
    
}
