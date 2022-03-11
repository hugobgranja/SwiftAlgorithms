//
//  KosarajuSharirSCCTests.swift
//  Created by hg on 09/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class SCCTests: XCTestCase {
    
    var createSut: ((Digraph) -> SCC)!
    var scc: SCC!
    var graph: Digraph!
    
    override class var defaultTestSuite: XCTestSuite {
        SCCTestSuite()
    }
    
    override func setUp() {
        super.setUp()
        
        graph = Digraph(vertices: 13)
        addTestData()
        
        scc = createSut(graph)
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
        scc = nil
    }

    func testConnected() {
        XCTAssertFalse(scc.isStronglyConnected(v: 1, w: 0))
        XCTAssertFalse(scc.isStronglyConnected(v: 7, w: 9))
        XCTAssertFalse(scc.isStronglyConnected(v: 0, w: 12))

        XCTAssertTrue(scc.isStronglyConnected(v: 0, w: 2))
        XCTAssertTrue(scc.isStronglyConnected(v: 0, w: 3))
        XCTAssertTrue(scc.isStronglyConnected(v: 0, w: 4))
        XCTAssertTrue(scc.isStronglyConnected(v: 0, w: 5))
        XCTAssertTrue(scc.isStronglyConnected(v: 2, w: 3))
        XCTAssertTrue(scc.isStronglyConnected(v: 3, w: 4))
        XCTAssertTrue(scc.isStronglyConnected(v: 4, w: 5))

        XCTAssertTrue(scc.isStronglyConnected(v: 6, w: 8))
        XCTAssertTrue(scc.isStronglyConnected(v: 8, w: 6))

        XCTAssertTrue(scc.isStronglyConnected(v: 9, w: 10))
        XCTAssertTrue(scc.isStronglyConnected(v: 10, w: 11))
        XCTAssertTrue(scc.isStronglyConnected(v: 11, w: 12))
    }

    func testId() {
        XCTAssertEqual(scc.id(vertex: 1), 0)
        XCTAssertEqual(scc.id(vertex: 0), 1)
        XCTAssertEqual(scc.id(vertex: 2), 1)
        XCTAssertEqual(scc.id(vertex: 3), 1)
        XCTAssertEqual(scc.id(vertex: 4), 1)
        XCTAssertEqual(scc.id(vertex: 5), 1)
        XCTAssertEqual(scc.id(vertex: 6), 3)
        XCTAssertEqual(scc.id(vertex: 7), 4)
        XCTAssertEqual(scc.id(vertex: 8), 3)
        XCTAssertEqual(scc.id(vertex: 9), 2)
        XCTAssertEqual(scc.id(vertex: 10), 2)
        XCTAssertEqual(scc.id(vertex: 11), 2)
        XCTAssertEqual(scc.id(vertex: 12), 2)
    }
    
    func testCount() {
        XCTAssertEqual(scc.count(), 5)
    }
    
}

extension SCCTests {
    
    func addTestData() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 0, w: 5)
        graph.addEdge(v: 2, w: 0)
        graph.addEdge(v: 3, w: 2)
        graph.addEdge(v: 3, w: 5)
        graph.addEdge(v: 4, w: 2)
        graph.addEdge(v: 4, w: 3)
        graph.addEdge(v: 5, w: 4)
        graph.addEdge(v: 6, w: 0)
        graph.addEdge(v: 6, w: 4)
        graph.addEdge(v: 6, w: 8)
        graph.addEdge(v: 6, w: 9)
        graph.addEdge(v: 7, w: 6)
        graph.addEdge(v: 7, w: 9)
        graph.addEdge(v: 8, w: 6)
        graph.addEdge(v: 9, w: 10)
        graph.addEdge(v: 9, w: 11)
        graph.addEdge(v: 10, w: 12)
        graph.addEdge(v: 11, w: 4)
        graph.addEdge(v: 11, w: 12)
        graph.addEdge(v: 12, w: 9)
    }
    
}
