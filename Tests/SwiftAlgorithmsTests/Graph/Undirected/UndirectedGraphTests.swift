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
        addTestData()
        
        let adjZero = graph.adjacent(to: 0)
        let adjOne = graph.adjacent(to: 1)
        let adjTwo = graph.adjacent(to: 2)
        
        XCTAssertEqual(adjZero, [1])
        XCTAssertEqual(adjOne, [0,4])
        XCTAssertEqual(adjTwo, [2,2])
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

}

extension UndirectedGraphTests {
    
    func addTestData() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 1, w: 4)
        graph.addEdge(v: 2, w: 2)
    }
    
}
