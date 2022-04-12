//
//  UndirectedDepthFirstSearchTests.swift
//  Created by hg on 12/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class UndirectedDepthFirstSearchTests: XCTestCase {
    
    var graph: UndirectedGraph!
    
    override func setUp() {
        super.setUp()
        graph = UndirectedGraph(vertices: 8)
        graph.addEdge(v: 0, w: 0)
        graph.addEdge(v: 0, w: 5)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 2, w: 0)
        graph.addEdge(v: 1, w: 7)
        graph.addEdge(v: 4, w: 3)
        graph.addEdge(v: 0, w: 2)
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
    }

    func testHasPath() {
        let paths = DepthFirstSearch(graph: graph, source: 0)
        XCTAssertTrue(paths.hasPath(to: 0))
        XCTAssertTrue(paths.hasPath(to: 5))
        XCTAssertTrue(paths.hasPath(to: 2))
        XCTAssertTrue(paths.hasPath(to: 3))
        XCTAssertTrue(paths.hasPath(to: 4))
        XCTAssertFalse(paths.hasPath(to: 7))
        XCTAssertFalse(paths.hasPath(to: 1))
        XCTAssertFalse(paths.hasPath(to: 6))
    }
    
    func testHasPathMultipleSources() {
        let paths = DepthFirstSearch(graph: graph, sources: [0, 1])
        XCTAssertTrue(paths.hasPath(to: 0))
        XCTAssertTrue(paths.hasPath(to: 5))
        XCTAssertTrue(paths.hasPath(to: 2))
        XCTAssertTrue(paths.hasPath(to: 3))
        XCTAssertTrue(paths.hasPath(to: 4))
        XCTAssertTrue(paths.hasPath(to: 7))
        XCTAssertTrue(paths.hasPath(to: 1))
        XCTAssertFalse(paths.hasPath(to: 6))
    }
    
}
