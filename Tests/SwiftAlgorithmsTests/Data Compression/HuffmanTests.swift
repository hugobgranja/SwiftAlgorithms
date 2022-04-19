//
//  HuffmanTests.swift
//  Created by hg on 18/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class HuffmanTests: XCTestCase {
    
    var sut: Huffman!
    
    override func setUp() {
        super.setUp()
        sut = Huffman()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testCompression() {
        let string = "ABRACADABRA!ALAKAZAM!"
        let compressed = sut.compress(string)
        let expanded = compressed.flatMap { sut.expand(data: $0) }
        XCTAssertEqual(string, expanded)
    }

}
