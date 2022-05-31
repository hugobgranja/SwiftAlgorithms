//
//  SortTests.swift
//  Created by hg on 13/10/2020.
//

import XCTest
@testable import SwiftAlgorithms

class SortTests: XCTestCase {
    
    var createSut: (() -> Sort)!
    var sort: Sort!
    
    override class var defaultTestSuite: XCTestSuite {
        SortTestSuite()
    }
    
    override func setUp() {
        super.setUp()
        sort = createSut()
    }
    
    override func tearDown() {
        super.tearDown()
        sort = nil
    }
    
    func testSortZero() {
        var array = [Int]()
        sort.sort(&array)
        XCTAssertTrue(SortUtil.isSorted(array))
    }
    
    func testSortOne() {
        var array = [5]
        sort.sort(&array)
        XCTAssertTrue(SortUtil.isSorted(array))
    }
    
    func testSortMultiple() {
        var array = [6,78,8,2392832,423,42,34,13405,1101,1,123,4,6980,193,4,2,5,6,8,9]
        sort.sort(&array)
        XCTAssertTrue(SortUtil.isSorted(array))
    }

}
