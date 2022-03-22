//
//  EdgeWeightedGraphTests.swift
//  Created by hg on 13/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class EdgeWeightedGraphTests: XCTestCase {
    
    var graph: EdgeWeightedGraph!
    
    override func setUp() {
        super.setUp()
        graph = EdgeWeightedGraph(vertices: 5)
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
        
        let expectedZero = [WeightedEdge(v: 0, w: 1, weight: 0.5)]
        
        let expectedOne = [
            WeightedEdge(v: 0, w: 1, weight: 0.5),
            WeightedEdge(v: 1, w: 4, weight: 1.1)
        ]
        
        let expectedTwo = [
            WeightedEdge(v: 2, w: 2, weight: 1.7),
            WeightedEdge(v: 2, w: 2, weight: 1.7)
        ]
        
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
    
    func testDegree() {
        addTestData()
        XCTAssertEqual(graph.degree(of: 0), 1)
        XCTAssertEqual(graph.degree(of: 1), 2)
        XCTAssertEqual(graph.degree(of: 2), 2)
    }
    
    func testGetEdges() {
        addTestData()
        
        let expected = [
            WeightedEdge(v: 0, w: 1, weight: 0.5),
            WeightedEdge(v: 1, w: 4, weight: 1.1),
            WeightedEdge(v: 2, w: 2, weight: 1.7)
        ]
        
        XCTAssertEqual(graph.getEdges(), expected)
    }

}

extension EdgeWeightedGraphTests {
    
    func addTestData() {
        graph.addEdge(v: 0, w: 1, weight: 0.5)
        graph.addEdge(v: 1, w: 4, weight: 1.1)
        graph.addEdge(v: 2, w: 2, weight: 1.7)
    }
    
}
