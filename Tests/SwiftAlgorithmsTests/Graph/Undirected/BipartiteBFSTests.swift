//
//  BipartiteBFSTests.swift
//  Created by hg on 24/05/2021.
//

import Foundation

import XCTest
@testable import SwiftAlgorithms

class BipartiteBFSTests: XCTestCase {
    
    var graph: Graph!
    
    override func setUp() {
        super.setUp()
        graph = UndirectedGraph(vertices: 9)
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
    }

    func testIsBipartite() {
        addTestData()
        let bipartite = BipartiteBFS(graph: graph)
        XCTAssertTrue(bipartite.isBipartite)
    }
    
    func testIsNotBipartite() {
        addTestData()
        graph.addEdge(v: 0, w: 8)
        let bipartite = BipartiteBFS(graph: graph)
        XCTAssertFalse(bipartite.isBipartite)
    }
    
    func testOddCycle() {
        addTestData()
        graph.addEdge(v: 0, w: 8)
        let bipartite = BipartiteBFS(graph: graph)
        XCTAssertEqual(bipartite.getOddCycle(), [8,0,1,8])
    }
    
    func testSelfLoop() {
        addTestData()
        graph.addEdge(v: 8, w: 8)
        let bipartiteDFS = BipartiteDFS(graph: graph)
        XCTAssertFalse(bipartiteDFS.isBipartite)
    }
    
    func testColor() {
        addTestData()
        let bipartite = BipartiteBFS(graph: graph)
        XCTAssertFalse(bipartite.color(vertex: 0))
        XCTAssertFalse(bipartite.color(vertex: 2))
        XCTAssertFalse(bipartite.color(vertex: 4))
        XCTAssertFalse(bipartite.color(vertex: 6))
        XCTAssertFalse(bipartite.color(vertex: 8))
        XCTAssertTrue(bipartite.color(vertex: 1))
        XCTAssertTrue(bipartite.color(vertex: 3))
        XCTAssertTrue(bipartite.color(vertex: 5))
        XCTAssertTrue(bipartite.color(vertex: 7))
    }
    
}

extension BipartiteBFSTests {
    
    private func addTestData() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 2, w: 1)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 4, w: 5)
        graph.addEdge(v: 6, w: 3)
        graph.addEdge(v: 8, w: 1)
        graph.addEdge(v: 8, w: 7)
    }
    
}
