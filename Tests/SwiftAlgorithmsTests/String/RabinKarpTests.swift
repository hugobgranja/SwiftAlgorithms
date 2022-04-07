//
//  RabinKarpTests.swift
//  Created by hg on 08/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class RabinKarpTests: XCTestCase {
    
    func testSearchMatch() {
        let rk = RabinKarp(pattern: "ABABAC")
        let index = rk.search("AABACAABABACAA")
        XCTAssertEqual(index, 6)
    }
    
    func testSearchNoMatch() {
        let rk = RabinKarp(pattern: "ABABAC")
        let index = rk.search("AABACAABABABCA")
        XCTAssertNil(index)
    }

}
