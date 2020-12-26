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
        select = ThreeWayQuickSelect()
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
        let tries = 100
        let maxSize = 20
        let maxNumber = 100

        for _ in 0...tries {
            let aSize = Int.random(in: 1...maxSize)
            var a = [Int]()
            
            for _ in 0..<aSize {
                a.append(Int.random(in: 0...maxNumber))
            }
            
            let sorted = a.sorted()
            
            for i in 0..<a.count {
                let element = select.select(&a, k: i)
                XCTAssertEqual(element, sorted[i])
            }
        }
    }
    
    static var allTests = [
        ("testSelectEmpty", testSelectEmpty),
        ("testSelectSingle", testSelectSingle),
        ("testSelect", testSelect)
    ]
}
