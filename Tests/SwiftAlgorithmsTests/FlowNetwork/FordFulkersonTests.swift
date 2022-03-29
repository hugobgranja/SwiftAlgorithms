//
//  FordFulkersonTests.swift
//  Created by hg on 26/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class FordFulkersonTests: XCTestCase {
    
    var sut: FordFulkerson!
    var fn: FlowNetwork!
    
    override func setUp() {
        super.setUp()
        fn = FlowNetwork(vertices: 8)
        addTestData()
        sut = FordFulkerson(flowNetwork: fn, source: 0, sink: 7)
    }
    
    override func tearDown() {
        super.tearDown()
        fn = nil
        sut = nil
    }
    
    func testMaxFlow() {
        XCTAssertEqual(sut.maxFlow(), 28)
    }
    
    func testMinCut() {
        XCTAssertTrue(sut.isInCut(vertex: 0))
        XCTAssertTrue(sut.isInCut(vertex: 2))
        XCTAssertTrue(sut.isInCut(vertex: 3))
        XCTAssertTrue(sut.isInCut(vertex: 6))
        XCTAssertFalse(sut.isInCut(vertex: 1))
        XCTAssertFalse(sut.isInCut(vertex: 4))
        XCTAssertFalse(sut.isInCut(vertex: 5))
        XCTAssertFalse(sut.isInCut(vertex: 7))
    }
    
}

extension FordFulkersonTests {
    
    func addTestData() {
        fn.addEdge(FlowEdge(from: 0, to: 1, capacity: 10))
        fn.addEdge(FlowEdge(from: 0, to: 2, capacity: 5))
        fn.addEdge(FlowEdge(from: 0, to: 3, capacity: 15))
        fn.addEdge(FlowEdge(from: 1, to: 2, capacity: 4))
        fn.addEdge(FlowEdge(from: 2, to: 3, capacity: 4))
        fn.addEdge(FlowEdge(from: 1, to: 4, capacity: 9))
        fn.addEdge(FlowEdge(from: 1, to: 5, capacity: 15))
        fn.addEdge(FlowEdge(from: 2, to: 5, capacity: 8))
        fn.addEdge(FlowEdge(from: 3, to: 6, capacity: 16))
        fn.addEdge(FlowEdge(from: 4, to: 5, capacity: 15))
        fn.addEdge(FlowEdge(from: 4, to: 7, capacity: 10))
        fn.addEdge(FlowEdge(from: 5, to: 7, capacity: 10))
        fn.addEdge(FlowEdge(from: 5, to: 6, capacity: 15))
        fn.addEdge(FlowEdge(from: 6, to: 2, capacity: 6))
        fn.addEdge(FlowEdge(from: 6, to: 7, capacity: 10))
    }
    
}
