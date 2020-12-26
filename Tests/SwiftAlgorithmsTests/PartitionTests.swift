//
//  PartitionTests.swift
//  Created by hg on 06/11/2020.
//

import XCTest
@testable import SwiftAlgorithms

final class PartitionTests: XCTestCase {
    
    var partition: Partition!
    
    override func setUp() {
        super.setUp()
        partition = HoarePartition()
    }
    
    override func tearDown() {
        super.tearDown()
        partition = nil
    }
    
    func testPartition() {
        var array = [10,6,78,8,10,10,42,34,13405,10,1,123,4,10,193,4,2,5,6,8,9]
        let low = 0, high = array.count - 1
        let index = partition.partition(&array, low, high)
        
        for i in low...index { XCTAssertTrue(array[i] <= array[index]) }
        for i in index+1...high { XCTAssertTrue(array[i] >= array[index] )}
    }

    static var allTests = [
        ("testPartition", testPartition)
    ]
}
