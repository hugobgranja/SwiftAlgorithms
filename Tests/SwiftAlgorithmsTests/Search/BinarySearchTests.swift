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
        XCTAssertNil(index)
    }
    
    func testSearchWhenNotContains() {
        let array = [1,2,3,4,5,6,7,8,9]
        let index = sut.indexOf(array, 10)
        XCTAssertNil(index)
    }
    
    func testSearchWhenContains() {
        let array = [1,2,3,4,5,6,7,8,9]
        let index = sut.indexOf(array, 5)
        XCTAssertEqual(index, 4)
    }
    
}
