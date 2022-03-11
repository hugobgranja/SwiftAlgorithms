//
//  TopologicalOrderTests.swift
//  Created by hg on 07/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class TopologicalOrderTests: XCTestCase {
    
    var graph: Digraph!
    var sut: TopologicalOrder!
    
    override func setUp() {
        super.setUp()
        graph = Digraph(vertices: 8)
        sut = TopologicalOrder()
        addTestData()
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
        sut = nil
    }

    func testTopologicalOrder() {
        let order = sut.getOrder(graph: graph)
        XCTAssertEqual(order, [6,4,1,7,0,2,3,5])
    }
    
    func testTopologicalOrderWhenCycleExists() {
        graph.addEdge(v: 3, w: 0)
        let order = sut.getOrder(graph: graph)
        XCTAssertNil(order)
    }
    
}

extension TopologicalOrderTests {
    
    private func addTestData() {
        graph.addEdge(v: 0, w: 5)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 1, w: 7)
        graph.addEdge(v: 4, w: 3)
        graph.addEdge(v: 0, w: 2)
    }
    
}
