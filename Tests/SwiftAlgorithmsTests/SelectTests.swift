//
//  SelectTests.swift
//  Created by hg on 06/11/2020.
//

import XCTest
@testable import SwiftAlgorithms

final class SelectTests: XCTestCase {
    
    var select: Select!
    
    override func setUp() {
        super.setUp()
        select = QuickSelect()
    }
    
    override func tearDown() {
        super.tearDown()
        select = nil
    }
    
    func testSelectEmpty() {
        var array = [Int]()
        let element = select.select(&array, k: 0)
        XCTAssertNil(element)
    }

    func testSelectSingle() {
        var array = [1]
        let element = select.select(&array, k: 0)
        XCTAssertEqual(element, 1)
    }
    
    func testSelect() {
        var array = [8,9,1,4,5,7,6,2,3,10]
        let sorted = array.sorted()
        
        for i in 0..<array.count {
            let element = select.select(&array, k: i)
            XCTAssertEqual(element, sorted[i])
        }
    }
    
    static var allTests = [
        ("testSelectEmpty", testSelectEmpty),
        ("testSelectSingle", testSelectSingle),
        ("testSelect", testSelect)
    ]
}
