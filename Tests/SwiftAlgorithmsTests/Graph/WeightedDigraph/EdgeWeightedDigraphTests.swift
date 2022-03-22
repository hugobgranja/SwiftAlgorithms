//
//  EdgeWeightedDigraphTests.swift
//  
//
//  Created by hg on 20/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class EdgeWeightedDigraphTests: XCTestCase {
    
    var graph: EdgeWeightedDigraph!
    
    override func setUp() {
        super.setUp()
        graph = EdgeWeightedDigraph(vertices: 5)
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
    }
    
    func testAddEdge() {
        addTestData()
        
        let adjZero = graph.adjacentEdges(to: 0)
        let adjOne = graph.adjacentEdges(to: 1)
        let adjTwo = graph.adjacentEdges(to: 2)
        
        let expectedZero = [DirectedEdge(from: 0, to: 1, weight: 0.5)]
        let expectedOne = [DirectedEdge(from: 1, to: 4, weight: 1.1)]
        let expectedTwo = [DirectedEdge(from: 2, to: 2, weight: 1.7)]
        
        XCTAssertEqual(adjZero, expectedZero)
        XCTAssertEqual(adjOne, expectedOne)
        XCTAssertEqual(adjTwo, expectedTwo)
    }
    
    func testVertexCount() {
        XCTAssertEqual(graph.vertexCount(), 5)
    }
    
    func testEdgeCount() {
        addTestData()
        XCTAssertEqual(graph.edgeCount(), 3)
    }
    
    func testIndegree() {
        addTestData()
        XCTAssertEqual(graph.indegree(of: 0), 0)
        XCTAssertEqual(graph.indegree(of: 1), 1)
        XCTAssertEqual(graph.indegree(of: 2), 1)
        XCTAssertEqual(graph.indegree(of: 4), 1)
    }
    
    func testOutdegree() {
        addTestData()
        XCTAssertEqual(graph.outdegree(of: 0), 1)
        XCTAssertEqual(graph.outdegree(of: 1), 1)
        XCTAssertEqual(graph.outdegree(of: 2), 1)
        XCTAssertEqual(graph.outdegree(of: 4), 0)
    }
    
    func testGetEdges() {
        addTestData()
        
        let expected = [
            DirectedEdge(from: 0, to: 1, weight: 0.5),
            DirectedEdge(from: 1, to: 4, weight: 1.1),
            DirectedEdge(from: 2, to: 2, weight: 1.7)
        ]
        
        XCTAssertEqual(graph.getEdges(), expected)
    }
    
    func testReversed() {
        addTestData()
        
        let reversed = graph.reversed()
        XCTAssertEqual(reversed.adjacent(to: 0), [])
        XCTAssertEqual(reversed.adjacent(to: 1), [0])
        XCTAssertEqual(reversed.adjacent(to: 2), [2])
        XCTAssertEqual(reversed.adjacent(to: 3), [])
        XCTAssertEqual(reversed.adjacent(to: 4), [1])
    }

}

extension EdgeWeightedDigraphTests {
    
    func addTestData() {
        graph.addEdge(from: 0, to: 1, weight: 0.5)
        graph.addEdge(from: 1, to: 4, weight: 1.1)
        graph.addEdge(from: 2, to: 2, weight: 1.7)
    }
    
}
