//
//  RabinKarpTests.swift
//  Created by hg on 08/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class RabinKarpTests: XCTestCase {
    
    func testSearchMatch() {
        let rk = RabinKarp(pattern: Array("ABABAC"))
        let index = rk.search(Array("AABACAABABACAA"))
        XCTAssertEqual(index, 6)
    }
    
    func testSearchNoMatch() {
        let rk = RabinKarp(pattern: Array("ABABAC"))
        let index = rk.search(Array("AABACAABABABCA"))
        XCTAssertNil(index)
    }

}
