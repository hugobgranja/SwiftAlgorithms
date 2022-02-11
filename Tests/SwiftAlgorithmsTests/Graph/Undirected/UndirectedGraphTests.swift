//
//  UndirectedGraphTest.swift
//  Created by hg on 03/04/2021.
//

import XCTest
@testable import SwiftAlgorithms

class UndirectedGraphTests: XCTestCase {
    
    var graph: UndirectedGraph!
    
    override func setUp() {
        super.setUp()
        graph = UndirectedGraph(vertices: 5)
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
    }
    
    func testAddEdge() {
        graph.addEdge(v: 0, w: 1)
        let adjZero = graph.adjacent(to: 0)
        let adjOne = graph.adjacent(to: 1)
        XCTAssertEqual(adjZero, [1])
        XCTAssertEqual(adjOne, [0])
    }
    
    func testVertexCount() {
        XCTAssertEqual(graph.vertexCount(), 5)
    }
    
    func testEdgeCount() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 1, w: 4)
        XCTAssertEqual(graph.edgeCount(), 2)
    }
    
    func testDegree() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 1, w: 4)
        XCTAssertEqual(graph.degree(of: 1), 2)
    }

}

