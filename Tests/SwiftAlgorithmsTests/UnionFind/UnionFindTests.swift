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
        sut.union(0, 5)
        XCTAssertTrue(sut.connected(0, 5))
        
        sut.union(6, 1)
        XCTAssertTrue(sut.connected(6, 1))
        
        sut.union(0, 1)
        XCTAssertTrue(sut.connected(5, 6))
        
        sut.union(8, 3)
        sut.union(3, 4)
        sut.union(4, 9)
        XCTAssertFalse(sut.connected(0, 9))
    }
    
    func testFind() {
        sut.union(0,5)
        XCTAssertEqual(sut.find(0), sut.find(5))
        
        sut.union(2,5)
        XCTAssertEqual(sut.find(0), sut.find(2))
        XCTAssertEqual(sut.find(0), sut.find(5))
        XCTAssertEqual(sut.find(2), sut.find(5))
    }
    
    func testComponents() {
        XCTAssertEqual(sut.components(), 10)
        
        sut.union(0,5)
        XCTAssertEqual(sut.components(), 9)
        
        sut.union(2,5)
        XCTAssertEqual(sut.components(), 8)
        
        sut.union(9,3)
        XCTAssertEqual(sut.components(), 7)
    }

}
