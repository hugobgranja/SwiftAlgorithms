//
//  ThreeWayRadixQSortTests.swift
//  Created by hg on 31/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class ThreeWayRadixQSortTests: XCTestCase {
    
    var sort: ThreeWayRadixQSort<String>!
    
    override func setUp() {
        super.setUp()
        sort = ThreeWayRadixQSort()
    }
    
    override func tearDown() {
        super.tearDown()
        sort = nil
    }
    
    func testSort() {
        var array = [
            "she", "sells", "seashells",
            "by", "the", "sea",
            "shore", "the", "shells",
            "she", "sells", "are",
            "surely", "sheashells"
        ]
        
        sort.sort(&array)
        XCTAssertTrue(SortUtil.isSorted(array))
    }

}
