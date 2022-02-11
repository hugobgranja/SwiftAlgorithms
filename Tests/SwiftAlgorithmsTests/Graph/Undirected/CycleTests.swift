//
//  CycleTests.swift
//  Created by hg on 03/04/2021.
//

import XCTest
@testable import SwiftAlgorithms

class CycleTests: XCTestCase {
    
    var graph: UndirectedGraph!
    
    override func setUp() {
        super.setUp()
        graph = UndirectedGraph(vertices: 8)
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
    }

    func testHasCycle() {
        addCycleTestData()
        let cycle = Cycle(graph: graph)
        XCTAssertTrue(cycle.hasCycle())
    }
    
    func testNoCycle() {
        graph.addEdge(v: 0, w: 5)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 1, w: 7)
        graph.addEdge(v: 4, w: 3)
        graph.addEdge(v: 0, w: 2)
        
        let cycle = Cycle(graph: graph)
        XCTAssertFalse(cycle.hasCycle())
    }
    
    func testGetCycle() {
        addCycleTestData()
        let cycle = Cycle(graph: graph)
        XCTAssertEqual(cycle.getCycle(), [4,0,2,3,4])
    }
    
    func testGetNoCycle() {
        addNoCycleTestData()
        let cycle = Cycle(graph: graph)
        XCTAssertEqual(cycle.getCycle(), [])
    }
    
    func testSelfLoop() {
        addNoCycleTestData()
        graph.addEdge(v: 4, w: 4)
        let cycle = Cycle(graph: graph)
        XCTAssertEqual(cycle.getCycle(), [4,4])
    }
    
    func testParallelEdges() {
        addNoCycleTestData()
        graph.addEdge(v: 0, w: 5)
        let cycle = Cycle(graph: graph)
        XCTAssertEqual(cycle.getCycle(), [0,5,0])
    }
    
}

extension CycleTests {
    
    func addNoCycleTestData() {
        graph.addEdge(v: 0, w: 5)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 1, w: 7)
        graph.addEdge(v: 4, w: 3)
        graph.addEdge(v: 0, w: 2)
    }
    
    func addCycleTestData() {
        addNoCycleTestData()
        graph.addEdge(v: 4, w: 0)
    }
    
}
