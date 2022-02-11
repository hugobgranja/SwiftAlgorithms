//
//  BipartiteDFSTests.swift
//  Created by hg on 23/05/2021.
//

import XCTest
@testable import SwiftAlgorithms

class BipartiteDFSTests: XCTestCase {
    
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
        let bipartiteDFS = BipartiteDFS(graph: graph)
        XCTAssertTrue(bipartiteDFS.isBipartite)
    }
    
    func testIsNotBipartite() {
        addTestData()
        graph.addEdge(v: 0, w: 8)
        let bipartiteDFS = BipartiteDFS(graph: graph)
        XCTAssertFalse(bipartiteDFS.isBipartite)
    }
    
    func testOddCycle() {
        addTestData()
        graph.addEdge(v: 0, w: 8)
        let bipartiteDFS = BipartiteDFS(graph: graph)
        XCTAssertEqual(bipartiteDFS.getOddCycle(), [8,0,1,8])
    }
    
    func testSelfLoop() {
        addTestData()
        graph.addEdge(v: 8, w: 8)
        let bipartiteDFS = BipartiteDFS(graph: graph)
        XCTAssertFalse(bipartiteDFS.isBipartite)
    }
    
    func testColor() {
        addTestData()
        let bipartiteDFS = BipartiteDFS(graph: graph)
        XCTAssertFalse(bipartiteDFS.color(vertex: 0))
        XCTAssertFalse(bipartiteDFS.color(vertex: 2))
        XCTAssertFalse(bipartiteDFS.color(vertex: 4))
        XCTAssertFalse(bipartiteDFS.color(vertex: 6))
        XCTAssertFalse(bipartiteDFS.color(vertex: 8))
        XCTAssertTrue(bipartiteDFS.color(vertex: 1))
        XCTAssertTrue(bipartiteDFS.color(vertex: 3))
        XCTAssertTrue(bipartiteDFS.color(vertex: 5))
        XCTAssertTrue(bipartiteDFS.color(vertex: 7))
    }
    
}

extension BipartiteDFSTests {
    
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
