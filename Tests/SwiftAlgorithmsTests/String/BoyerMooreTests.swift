//
//  BoyerMooreTests.swift
//  Created by hg on 07/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class BoyerMooreTests: XCTestCase {
    
    func testSearchMatch() {
        let bm = BoyerMoore(pattern: Array("ABABAC"))
        let index = bm.search(Array("AABACAABABACAA"))
        XCTAssertEqual(index, 6)
    }
    
    func testSearchNoMatch() {
        let bm = BoyerMoore(pattern: Array("ABABAC"))
        let index = bm.search(Array("AABACAABABABCA"))
        XCTAssertNil(index)
    }

}
