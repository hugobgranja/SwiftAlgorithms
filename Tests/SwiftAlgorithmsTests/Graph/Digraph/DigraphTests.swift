//
//  DigraphTests.swift
//  Created by hg on 07/03/2022.
//

import Foundation

import XCTest
@testable import SwiftAlgorithms

class DigraphTests: XCTestCase {
    
    var graph: Digraph!
    
    override func setUp() {
        super.setUp()
        graph = Digraph(vertices: 5)
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
    }
    
    func testAddEdge() {
        graph.addEdge(v: 0, w: 1)
        let adjZero = graph.adjacent(to: 0)
        XCTAssertEqual(adjZero, [1])
    }
    
    func testVertexCount() {
        XCTAssertEqual(graph.vertexCount(), 5)
    }
    
    func testEdgeCount() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 1, w: 4)
        XCTAssertEqual(graph.edgeCount(), 2)
    }
    
    func testoOutdegree() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 1, w: 4)
        XCTAssertEqual(graph.outdegree(of: 1), 1)
    }
    
    func testIndegree() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 1, w: 4)
        XCTAssertEqual(graph.indegree(of: 1), 1)
    }

}
