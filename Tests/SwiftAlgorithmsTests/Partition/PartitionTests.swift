//
//  PartitionTests.swift
//  Created by hg on 06/11/2020.
//

import XCTest
@testable import SwiftAlgorithms

class PartitionTests: XCTestCase {

    var createSut: (() -> Partition)!
    var sut: Partition!

    override class var defaultTestSuite: XCTestSuite {
        PartitionTestSuite()
    }

    override func setUp() {
        super.setUp()
        sut = createSut()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testPartition() {
        var array = [10,6,78,8,10,10,42,34,13405,10,1,123,4,10,193,4,2,5,6,8,9]
        let low = 0, high = array.count - 1
        let index = sut.partition(&array, low, high)

        for i in low...index { XCTAssertTrue(array[i] <= array[index]) }
        for i in index+1...high { XCTAssertTrue(array[i] >= array[index] )}
    }

}
