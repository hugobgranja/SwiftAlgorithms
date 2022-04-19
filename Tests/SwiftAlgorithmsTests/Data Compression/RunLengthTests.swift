//
//  RunLengthTests.swift
//  Created by hg on 15/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class RunLengthTests: XCTestCase {
    
    var sut: RunLength!
    
    override func setUp() {
        super.setUp()
        sut = RunLength()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testCompression() {
        let data = Data([0, 0, 0, 0, 63, 252])
        let compressed = sut.compress(data: data)
        let expected = Data([34, 12, 2])
        XCTAssertEqual(compressed, expected)
    }
    
    func testExpansion() {
        let original = Data(repeating: 0, count: 33) + [63, 252]
        let compressed = sut.compress(data: original)
        let expanded = sut.expand(data: compressed)
        XCTAssertEqual(original, expanded)
    }

}
