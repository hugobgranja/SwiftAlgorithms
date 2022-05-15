//
//  AhoCorasickTests.swift
//  Created by hg on 15/05/2022.
//

import XCTest
@testable import SwiftAlgorithms

class AhoCorassickTests: XCTestCase {
    
    func testMatches() {
        let ac = AhoCorasick(patterns: ["i", "in", "tin", "sting"])
        let string = "interesting"
        let ranges = ac.matches(in: string)
        XCTAssertEqual(ranges.count, 6)
        XCTAssertEqual(string[ranges[0]], "i")
        XCTAssertEqual(string[ranges[1]], "in")
        XCTAssertEqual(string[ranges[2]], "i")
        XCTAssertEqual(string[ranges[3]], "tin")
        XCTAssertEqual(string[ranges[4]], "in")
        XCTAssertEqual(string[ranges[5]], "sting")
    }
    
    func testNoMatches() {
        let ac = AhoCorasick(patterns: ["i", "in", "tin", "sting"])
        let ranges = ac.matches(in: "abracadabra")
        XCTAssertEqual(ranges, [])
    }

}
