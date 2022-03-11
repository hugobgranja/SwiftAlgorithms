//
//  ConnectedComponentsTests.swift
//  Created by hg on 03/04/2021.
//

import XCTest
@testable import SwiftAlgorithms

class ConnectedComponentsTests: XCTestCase {
    
    var graph: UndirectedGraph!
    var cc: ConnectedComponents!
    
    override func setUp() {
        super.setUp()
        
        graph = UndirectedGraph(vertices: 8)
        graph.addEdge(v: 0, w: 0)
        graph.addEdge(v: 0, w: 5)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 1, w: 7)
        graph.addEdge(v: 4, w: 3)
        graph.addEdge(v: 0, w: 2)
        
        cc = ConnectedComponents(graph: graph)
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
        cc = nil
    }

    func testConnected() {
        XCTAssertTrue(cc.isConnected(v: 0, w: 5))
        XCTAssertTrue(cc.isConnected(v: 0, w: 2))
        XCTAssertTrue(cc.isConnected(v: 0, w: 3))
        XCTAssertTrue(cc.isConnected(v: 0, w: 4))
        XCTAssertTrue(cc.isConnected(v: 4, w: 0))
        XCTAssertTrue(cc.isConnected(v: 1, w: 7))
        XCTAssertTrue(cc.isConnected(v: 7, w: 1))
        XCTAssertFalse(cc.isConnected(v: 2, w: 1))
        XCTAssertFalse(cc.isConnected(v: 2, w: 6))
        XCTAssertFalse(cc.isConnected(v: 7, w: 6))
    }
    
    func testId() {
        XCTAssertEqual(cc.id(vertex: 0), 0)
        XCTAssertEqual(cc.id(vertex: 2), 0)
        XCTAssertEqual(cc.id(vertex: 3), 0)
        XCTAssertEqual(cc.id(vertex: 4), 0)
        XCTAssertEqual(cc.id(vertex: 5), 0)
        XCTAssertEqual(cc.id(vertex: 1), 1)
        XCTAssertEqual(cc.id(vertex: 7), 1)
        XCTAssertEqual(cc.id(vertex: 6), 2)
    }
    
    func testCount() {
        XCTAssertEqual(cc.count(), 3)
    }
    
    func testSize() {
        XCTAssertEqual(cc.size(vertex: 0), 5)
        XCTAssertEqual(cc.size(vertex: 2), 5)
        XCTAssertEqual(cc.size(vertex: 3), 5)
        XCTAssertEqual(cc.size(vertex: 4), 5)
        XCTAssertEqual(cc.size(vertex: 5), 5)
        XCTAssertEqual(cc.size(vertex: 1), 2)
        XCTAssertEqual(cc.size(vertex: 7), 2)
        XCTAssertEqual(cc.size(vertex: 6), 1)
    }
    
}
