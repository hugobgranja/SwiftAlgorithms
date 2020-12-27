//
//  SortingTests.swift
//  Created by hg on 13/10/2020.
//

import XCTest
@testable import SwiftAlgorithms

final class SortingTests: XCTestCase {
    
    var sort: Sort!
    
    override func setUp() {
        super.setUp()
        sort = HeapSort()
    }
    
    override func tearDown() {
        super.tearDown()
        sort = nil
    }
    
    func testSortEmpty() {
        var array = [Int]()
        sort.sort(&array)
        XCTAssertTrue(isSorted(array))
    }
    
    func testSort() {
        var array = [1,6,78,8,2392832,423,42,34,13405,1101,1,123,4,6980,193,4,2,5,6,8,9]
        sort.sort(&array)
        XCTAssertTrue(isSorted(array))
    }
    
    func testIsSortedEmpty() {
        let array = [Int]()
        XCTAssertTrue(isSorted(array))
    }
    
    func testIsSorted() {
        let sortedArray = [1,2,3,4,5,6,7,8,9,10,123,124,1023,1567,1892,9876]
        XCTAssertTrue(isSorted(sortedArray))
        
        let unsortedArray = [1,2,9,4,5,6,7,8,9,10,11,12,1001,1002,5]
        XCTAssertFalse(isSorted(unsortedArray))
    }
    
    private func isSorted<T: Comparable>(_ array: [T]) -> Bool {
        var i = 1
        while i < array.count {
            if array[i] < array[i - 1] { return false }
            i += 1
        }
        return true
    }

    static var allTests = [
        ("testSortEmpty", testSortEmpty),
        ("testSort", testSort),
        ("testIsSortedEmpty", testIsSortedEmpty),
        ("testIsSorted", testIsSorted)
    ]
}
