//
//  DepthFirstOrderTests.swift
//  Created by hg on 07/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class DepthFirstOrderTests: XCTestCase {
    
    var graph: Digraph!
    var sut: DepthFirstOrder!
    
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
        
        sut = DepthFirstOrder(graph: graph)
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
        sut = nil
    }

    func testPreorder() {
        let order = sut.getPreorder()
        XCTAssertEqual(order, [0,5,2,3,1,7,4,6])
    }
    
    func testPostorder() {
        let order = sut.getPostorder()
        XCTAssertEqual(order, [5,3,2,0,7,1,4,6])
    }
    
}
