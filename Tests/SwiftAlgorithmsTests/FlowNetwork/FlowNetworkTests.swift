//
//  FlowNetworkTests.swift
//
//
//  Created by hg on 20/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class FlowNetworkTests: XCTestCase {
    
    var sut: FlowNetwork!
    
    override func setUp() {
        super.setUp()
        sut = FlowNetwork(vertices: 3)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testAddEdge() {
        addTestData()
        
        let adjZero = sut.adjacentEdges(to: 0)
        let adjOne = sut.adjacentEdges(to: 1)
        let adjTwo = sut.adjacentEdges(to: 2)
        
        let expectedZero = [FlowEdge(from: 0, to: 1, capacity: 5)]
        
        let expectedOne = [
            FlowEdge(from: 0, to: 1, capacity: 5),
            FlowEdge(from: 1, to: 2, capacity: 10)
        ]
        
        let expectedTwo = [FlowEdge(from: 1, to: 2, capacity: 10)]
        
        XCTAssertEqual(adjZero, expectedZero)
        XCTAssertEqual(adjOne, expectedOne)
        XCTAssertEqual(adjTwo, expectedTwo)
    }
    
    func testVertexCount() {
        XCTAssertEqual(sut.vertexCount(), 3)
    }
    
    func testEdgeCount() {
        addTestData()
        XCTAssertEqual(sut.edgeCount(), 2)
    }
    
    func testGetEdges() {
        addTestData()
        
        let expected = [
            FlowEdge(from: 0, to: 1, capacity: 5),
            FlowEdge(from: 1, to: 2, capacity: 10)
        ]
        
        XCTAssertEqual(sut.getEdges(), expected)
    }

}

extension FlowNetworkTests {
    
    func addTestData() {
        sut.addEdge(FlowEdge(from: 0, to: 1, capacity: 5))
        sut.addEdge(FlowEdge(from: 1, to: 2, capacity: 10))
    }
    
}
