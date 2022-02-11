//
//  UnionFindTests.swift
//  Created by hg on 26/09/2020.
//

import XCTest
@testable import SwiftAlgorithms

class UnionFindTests: XCTestCase {
    
    var createSut: (() -> UnionFind)!
    var sut: UnionFind!
    
    override class var defaultTestSuite: XCTestSuite {
        UnionFindTestSuite()
    }
    
    override func setUp() {
        super.setUp()
        sut = createSut()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testUnion() {
        try! sut.union(0, 5)
        XCTAssertTrue(try! sut.connected(0, 5))
        
        try! sut.union(6, 1)
        XCTAssertTrue(try! sut.connected(6, 1))
        
        try! sut.union(0, 1)
        XCTAssertTrue(try! sut.connected(5, 6))
        
        try! sut.union(8, 3)
        try! sut.union(3, 4)
        try! sut.union(4, 9)
        XCTAssertFalse(try! sut.connected(0, 9))
    }
    
    func testFind() {
        try! sut.union(0,5)
        XCTAssertEqual(try! sut.find(0), try! sut.find(5))
        
        try! sut.union(2,5)
        XCTAssertEqual(try! sut.find(0), try! sut.find(2))
        XCTAssertEqual(try! sut.find(0), try! sut.find(5))
        XCTAssertEqual(try! sut.find(2), try! sut.find(5))
    }
    
    func testComponents() {
        XCTAssertEqual(sut.components(), 10)
        
        try! sut.union(0,5)
        XCTAssertEqual(sut.components(), 9)
        
        try! sut.union(2,5)
        XCTAssertEqual(sut.components(), 8)
        
        try! sut.union(9,3)
        XCTAssertEqual(sut.components(), 7)
    }

}
