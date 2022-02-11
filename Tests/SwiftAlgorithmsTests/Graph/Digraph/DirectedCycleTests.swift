//
//  DirectedCycleTests.swift
//  
//
//  Created by hg on 07/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class DirectedCycleTests: XCTestCase {
    
    var graph: Digraph!
    
    override func setUp() {
        super.setUp()
        graph = Digraph(vertices: 8)
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
    }

    func testHasCycle() {
        addCycleTestData()
        let cycle = DirectedCycle(graph: graph)
        XCTAssertTrue(cycle.hasCycle())
    }
    
    func testNoCycle() {
        addNoCycleTestData()
        let cycle = DirectedCycle(graph: graph)
        XCTAssertFalse(cycle.hasCycle())
    }
    
    func testGetCycle() {
        addCycleTestData()
        let cycle = DirectedCycle(graph: graph)
        XCTAssertEqual(cycle.getCycle(), [0,2,3,4,0])
    }
    
    func testGetNoCycle() {
        addNoCycleTestData()
        let cycle = DirectedCycle(graph: graph)
        XCTAssertEqual(cycle.getCycle(), [])
    }
    
    func testSelfLoop() {
        addNoCycleTestData()
        graph.addEdge(v: 4, w: 4)
        let cycle = DirectedCycle(graph: graph)
        XCTAssertEqual(cycle.getCycle(), [4,4])
    }
    
}

extension DirectedCycleTests {
    
    private func addCycleTestData() {
        graph.addEdge(v: 0, w: 5)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 1, w: 7)
        graph.addEdge(v: 3, w: 4)
        graph.addEdge(v: 0, w: 2)
        graph.addEdge(v: 4, w: 0)
    }
    
    private func addNoCycleTestData() {
        graph.addEdge(v: 0, w: 5)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 1, w: 7)
        graph.addEdge(v: 4, w: 3)
        graph.addEdge(v: 0, w: 2)
        graph.addEdge(v: 4, w: 0)
    }
    
}
