//
//  ThreeWayPartitionTests.swift
//  Created by hg on 06/11/2020.
//

import XCTest
@testable import SwiftAlgorithms

class ThreeWayPartitionTests: XCTestCase {
    
    var sut: ThreeWayPartition!
    
    override func setUp() {
        super.setUp()
        sut = ThreeWayPartition()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testPartition() {
        var array = [10,6,78,8,10,423,42,34,10,10,1,123,4,10,193,4,2,5,6,8,9]
        let low = 0, high = array.count - 1
        let (lt, gt) = sut.partition(&array, low, high)
        
        for i in low...lt-1 { XCTAssertTrue(array[i] < array[lt]) }
        for i in lt...gt { XCTAssertTrue(array[i] == array[lt]) }
        for i in gt+1...high { XCTAssertTrue(array[i] >= array[lt] )}
    }

}
