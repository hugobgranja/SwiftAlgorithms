//
//  LSDSortTests.swift
//  Created by hg on 31/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class LSDSortTests: XCTestCase {
    
    var sort: LSDSort!
    
    override func setUp() {
        super.setUp()
        sort = LSDSort()
    }
    
    override func tearDown() {
        super.tearDown()
        sort = nil
    }
    
    func testSortASCII() {
        var array = createSortASCIITestData()
        sort.sortASCII(&array, charCount: 3)
        
        let expected = [
            "ace", "add", "bad",
            "bed", "bee", "cab",
            "dab", "dad", "ebb",
            "fad", "fed", "fee"
        ].map {
            Array($0)
        }
        
        XCTAssertEqual(array, expected)
    }
    
    func testSortInt() {
        var array = createSortIntTestData()
        sort.sort(&array)
        XCTAssertTrue(SortUtil.isSorted(array))
    }

}

extension LSDSortTests {
    
    func createSortASCIITestData() -> [[Character]] {
        return [
            "dab", "cab", "fad",
            "bad", "dad", "ebb",
            "ace", "add", "fed",
            "bed", "fee", "bee"
        ].map {
            Array($0)
        }
    }
    
    func createSortIntTestData() -> [Int] {
        return [123,512599,1209,999,451,235,8901238,1234,123,11,92, Int.max, Int.min, 0]
    }
    
}
