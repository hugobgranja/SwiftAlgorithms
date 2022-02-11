//
//  SelectTests.swift
//  Created by hg on 06/11/2020.
//

import XCTest
@testable import SwiftAlgorithms

class SelectTests: XCTestCase {
    
    var createSut: (() -> Select)!
    var sut: Select!
    
    override class var defaultTestSuite: XCTestSuite {
        SelectTestSuite()
    }
    
    override func setUp() {
        super.setUp()
        sut = createSut()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testSelectEmpty() {
        var array = [Int]()
        let element = sut.select(&array, k: 0)
        XCTAssertNil(element)
    }

    func testSelectSingle() {
        var array = [1]
        let element = sut.select(&array, k: 0)
        XCTAssertEqual(element, 1)
    }
    
    func testSelectMany() {
        var array = [20,19,18,14,16,15,1,5,9,7,8]
        let sorted = array.sorted()
        
        for i in array.indices {
            let element = sut.select(&array, k: i)
            XCTAssertEqual(element, sorted[i])
        }
    }

}
