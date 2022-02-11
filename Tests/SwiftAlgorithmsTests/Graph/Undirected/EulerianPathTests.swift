//
//  EulerianPathTests.swift
//  Created by hg on 05/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class EulerianPathTests: XCTestCase {
    
    var graph: UndirectedGraph!
    var sut: EulerianPath!
    
    override func setUp() {
        super.setUp()
        graph = UndirectedGraph(vertices: 6)
        sut = EulerianPath()
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
        sut = nil
    }

    func testEulerianPathExists() {
        graph.addEdge(v: 0, w: 5)
        graph.addEdge(v: 0, w: 2)
        graph.addEdge(v: 5, w: 2)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 2, w: 4)
        graph.addEdge(v: 3, w: 4)
        graph.addEdge(v: 4, w: 4)
        
        let path = sut.findEulerianPath(graph: graph)
        XCTAssertEqual(path, [0,5,2,3,4,4,2,0])
    }
    
    func testEulerianPathExistsWhenSourceOddVertex() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 0, w: 4)
        graph.addEdge(v: 1, w: 3)
        graph.addEdge(v: 4, w: 3)
        graph.addEdge(v: 4, w: 2)
        
        let path = sut.findEulerianPath(graph: graph)
        XCTAssertEqual(path, [4,0,1,3,4,2])
    }
    
    func testEulerianPathNotExistsWhenNonSingleConnectedComponent() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 2, w: 1)
        graph.addEdge(v: 2, w: 3)
        graph.addEdge(v: 4, w: 5)
        
        let path = sut.findEulerianPath(graph: graph)
        XCTAssertNil(path)
    }
    
    func testEulerianPathNotExistsWhenOddVerticesCountLargerThanTwo() {
        graph.addEdge(v: 0, w: 1)
        graph.addEdge(v: 1, w: 2)
        graph.addEdge(v: 2, w: 4)
        graph.addEdge(v: 3, w: 1)
        graph.addEdge(v: 3, w: 2)
        graph.addEdge(v: 3, w: 4)
        
        let path = sut.findEulerianPath(graph: graph)
        XCTAssertNil(path)
    }
    
}
