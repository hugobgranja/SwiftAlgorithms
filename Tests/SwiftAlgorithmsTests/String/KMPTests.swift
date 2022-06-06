//
//  KMPTests.swift
//  Created by hg on 07/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class KMPTests: XCTestCase {
    
    func testSearchMatch() {
        let text = "AABACAABABACAA"
        let pattern = "ABABAC"
        let kmp = KMP(pattern: pattern)
        let index = kmp.search(text)
        let expected = text.index(text.startIndex, offsetBy: 6)
        XCTAssertEqual(index, expected)
    }
    
    func testSearchNoMatch() {
        let kmp = KMP(pattern: "ABABAC")
        let index = kmp.search("AABACAABABABCA")
        XCTAssertNil(index)
    }

}
