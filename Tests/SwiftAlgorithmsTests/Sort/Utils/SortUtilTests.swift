//
//  SortUtilTests.swift
//  Created by hg on 01/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class SortUtilTests: XCTestCase {
    
    func testIsSortedWhenEmpty() {
        let array = [Int]()
        XCTAssertTrue(SortUtil.isSorted(array))
    }

    func testIsSorted() {
        let sortedArray = [1,2,3,4,5,6,7,8,9,10,123,124,1023,1567,1892,9876]
        XCTAssertTrue(SortUtil.isSorted(sortedArray))
        
        let unsortedArray = [1,2,9,4,5,6,7,8,9,10,11,12,1001,1002,5]
        XCTAssertFalse(SortUtil.isSorted(unsortedArray))
    }


}
