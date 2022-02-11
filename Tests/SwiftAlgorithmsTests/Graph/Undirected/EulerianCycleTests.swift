//
//  EulerianCycleTests.swift
//  Created by hg on 06/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class EulerianCycleTests: XCTestCase {
    
    var graph: UndirectedGraph!
    var sut: EulerianCycle!
    
    override func setUp() {
        super.setUp()
        graph = UndirectedGraph(vertices: 6)
        sut = EulerianCycle()
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
        sut = nil
    }

    func testEulerianCycleExists() {
        graph.addEdge(v: 0, w: 5)
        graph.addEdge(v: 0, w: 2)
        graph.addEdge(v: 5, w: 2)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 2, w: 4)
        graph.addEdge(v: 3, w: 4)
        graph.addEdge(v: 4, w: 4)
        
        let cycle = sut.findEulerianCycle(graph: graph)
        XCTAssertEqual(cycle, [0,5,2,3,4,4,2,0])
    }
    
    func testEulerianCycleNotExistsWhenContainsOddVertex() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 0, w: 4)
        graph.addEdge(v: 1, w: 3)
        graph.addEdge(v: 4, w: 3)
        graph.addEdge(v: 4, w: 2)
        
        let cycle = sut.findEulerianCycle(graph: graph)
        XCTAssertNil(cycle)
    }
    
    func testEulerianPathNotExistsWhenNonSingleConnectedComponent() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 2, w: 1)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 4, w: 5)
        
        let path = sut.findEulerianCycle(graph: graph)
        XCTAssertNil(path)
    }
    
}
