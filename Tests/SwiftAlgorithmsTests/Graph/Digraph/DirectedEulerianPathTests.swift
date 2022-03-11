//
//  DirectedEulerianPathTests.swift
//  Created by hg on 08/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class DirectedEulerianPathTests: XCTestCase {
    
    var graph: Digraph!
    var sut: DirectedEulerianPath!
    
    override func setUp() {
        super.setUp()
        graph = Digraph(vertices: 6)
        sut = DirectedEulerianPath()
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
        sut = nil
    }

    func testEulerianPathExists() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 0, w: 2)
        graph.addEdge(v: 1, w: 3)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 3, w: 0)
        graph.addEdge(v: 1, w: 1)
        
        let path = sut.findEulerianPath(graph: graph)
        XCTAssertEqual(path, [0,1,1,3,0,2,3])
    }
    
    func testEulerianPathNotExists() {
        graph.addEdge(v: 0, w: 2)
        graph.addEdge(v: 1, w: 3)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 3, w: 0)
        graph.addEdge(v: 4, w: 1)
        graph.addEdge(v: 4, w: 2)
        
        let path = sut.findEulerianPath(graph: graph)
        XCTAssertNil(path)
    }
    
    func testEulerianPathNotExistsWhenNonSingleConnectedComponent() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 1, w: 2)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 4, w: 5)
        
        let path = sut.findEulerianPath(graph: graph)
        XCTAssertNil(path)
    }
    
}
