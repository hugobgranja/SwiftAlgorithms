//
//  LZWTests.swift
//  Created by hg on 20/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class LZWTests: XCTestCase {
    
    var sut: LZW!
    
    override func setUp() {
        super.setUp()
        sut = LZW()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testCompression() {
        let string = "ABABABA"
        let compressed = sut.compress(string)
        let reader = BinaryDataReader(data: compressed)
        let expected = [65, 66, 129, 131, 128]
        
        for value in expected {
            let int = reader.readInt(bitWidth: 12)
            XCTAssertEqual(value, int)
        }
    }
    
    func testExpansion() {
        let string = "BBBABAB"
        let compressed = sut.compress(string)
        let expanded = sut.expand(data: compressed)
        XCTAssertEqual(string, expanded)
    }

}
