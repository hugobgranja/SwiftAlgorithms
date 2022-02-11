//
//  DirectedDepthFirstPathsTests.swift
//  Created by hg on 03/04/2021.
//


import XCTest
@testable import SwiftAlgorithms

class DirectedDepthFirstPathsTests: XCTestCase {
    
    var graph: Digraph!
    
    override func setUp() {
        super.setUp()
        graph = Digraph(vertices: 8)
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
        let paths = DepthFirstPaths(graph: graph, source: 0)
        XCTAssertTrue(paths.hasPath(to: 0))
        XCTAssertTrue(paths.hasPath(to: 5))
        XCTAssertTrue(paths.hasPath(to: 2))
        XCTAssertTrue(paths.hasPath(to: 3))
        XCTAssertFalse(paths.hasPath(to: 4))
        XCTAssertFalse(paths.hasPath(to: 7))
        XCTAssertFalse(paths.hasPath(to: 1))
        XCTAssertFalse(paths.hasPath(to: 6))
    }
    
    func testPath() {
        let paths = DepthFirstPaths(graph: graph, source: 0)
        XCTAssertEqual(paths.path(to: 3), [0,2,3])
    }
    
    func testNoPath() {
        let paths = DepthFirstPaths(graph: graph, source: 0)
        XCTAssertNil(paths.path(to: 4))
    }
    
}
