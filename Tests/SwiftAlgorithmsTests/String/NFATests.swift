//
//  NFATests.swift
//  Created by hg on 12/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class NFATests: XCTestCase {
    
    func testText() {
        let nfa = try! NFA(regex: "(Hello 123)")
        XCTAssertTrue(try! nfa.recognizes(text: "Hello 123"))
        XCTAssertFalse(try! nfa.recognizes(text: "Hello 124"))
    }
    
    func testStar() {
        let nfa = try! NFA(regex: "(A*)")
        XCTAssertTrue(try! nfa.recognizes(text: ""))
        XCTAssertTrue(try! nfa.recognizes(text: "A"))
        XCTAssertTrue(try! nfa.recognizes(text: "AAAAA"))
    }
    
    func testOr() {
        let nfa = try! NFA(regex: "((A|B))")
        XCTAssertTrue(try! nfa.recognizes(text: "A"))
        XCTAssertTrue(try! nfa.recognizes(text: "B"))
        XCTAssertFalse(try! nfa.recognizes(text: "C"))
    }
    
    func testOrStar() {
        let nfa = try! NFA(regex: "(A(A|B)*)")
        XCTAssertTrue(try! nfa.recognizes(text: "A"))
        XCTAssertTrue(try! nfa.recognizes(text: "AB"))
        XCTAssertTrue(try! nfa.recognizes(text: "AA"))
        XCTAssertTrue(try! nfa.recognizes(text: "BA"))
        XCTAssertFalse(try! nfa.recognizes(text: "B"))
        XCTAssertFalse(try! nfa.recognizes(text: "BB"))
        XCTAssertFalse(try! nfa.recognizes(text: "C"))
    }
    
    func testPlus() {
        let nfa = try! NFA(regex: "(A+)")
        XCTAssertTrue(try! nfa.recognizes(text: "A"))
        XCTAssertTrue(try! nfa.recognizes(text: "AAAAA"))
        XCTAssertFalse(try! nfa.recognizes(text: ""))
    }
    
    func testOrPlus() {
        let nfa = try! NFA(regex: "((A|B)+)")
        XCTAssertTrue(try! nfa.recognizes(text: "A"))
        XCTAssertTrue(try! nfa.recognizes(text: "B"))
        XCTAssertTrue(try! nfa.recognizes(text: "AB"))
        XCTAssertTrue(try! nfa.recognizes(text: "AA"))
        XCTAssertTrue(try! nfa.recognizes(text: "BA"))
        XCTAssertFalse(try! nfa.recognizes(text: ""))
        XCTAssertFalse(try! nfa.recognizes(text: "C"))
    }
    
    func testWildcard() {
        let nfa = try! NFA(regex: "A.B")
        XCTAssertTrue(try! nfa.recognizes(text: "ACB"))
        XCTAssertTrue(try! nfa.recognizes(text: "AGB"))
        XCTAssertFalse(try! nfa.recognizes(text: "AA"))
        XCTAssertFalse(try! nfa.recognizes(text: "AB"))
        XCTAssertFalse(try! nfa.recognizes(text: "B"))
        XCTAssertFalse(try! nfa.recognizes(text: "BB"))
        XCTAssertFalse(try! nfa.recognizes(text: "C"))
    }
    
    func testMultiway() {
        let nfa = try! NFA(regex: "(A|B|C)")
        XCTAssertTrue(try! nfa.recognizes(text: "A"))
        XCTAssertTrue(try! nfa.recognizes(text: "B"))
        XCTAssertTrue(try! nfa.recognizes(text: "C"))
        XCTAssertFalse(try! nfa.recognizes(text: "D"))
    }
    
    func testThrowsOnMismatchedParenthesis() {
        XCTAssertThrowsError(try NFA(regex: "((A|B)"))
        XCTAssertThrowsError(try NFA(regex: "(A|B))"))
    }

    func testThrowsOnMetacharacterUseInText() {
        let nfa = try! NFA(regex: "(A*)")
        XCTAssertThrowsError(try nfa.recognizes(text: "(A"))
        XCTAssertThrowsError(try nfa.recognizes(text: "A|"))
        XCTAssertThrowsError(try nfa.recognizes(text: "A)"))
        XCTAssertThrowsError(try nfa.recognizes(text: "A*"))
    }
    
}
