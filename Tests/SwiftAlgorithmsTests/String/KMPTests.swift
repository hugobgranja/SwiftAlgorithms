//
//  KMPTests.swift
//  Created by hg on 07/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class KMPTests: XCTestCase {
    
    func testSearchMatch() {
        let kmp = KMP(pattern: "ABABAC")
        let index = kmp.search("AABACAABABACAA")
        XCTAssertEqual(index, 6)
    }
    
    func testSearchNoMatch() {
        let kmp = KMP(pattern: "ABABAC")
        let index = kmp.search("AABACAABABABCA")
        XCTAssertNil(index)
    }

}
