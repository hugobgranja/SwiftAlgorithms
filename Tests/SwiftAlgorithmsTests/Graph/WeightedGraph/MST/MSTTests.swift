//
//  MSTTests.swift
//  Created by hg on 13/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class MSTTests: XCTestCase {
    
    var createSut: ((EdgeWeightedGraph) -> MST)!
    var mst: MST!
    var graph: EdgeWeightedGraph!
    
    override class var defaultTestSuite: XCTestSuite {
        MSTTestSuite()
    }
    
    override func setUp() {
        super.setUp()
        
        graph = EdgeWeightedGraph(vertices: 8)
        addTestData()
        mst = createSut(graph)
    }
    
    override func tearDown() {
        super.tearDown()
        graph = nil
        mst = nil
    }

    func testMST() {
        addTestData()
        
        let expected: Set<WeightedEdge> = [
            WeightedEdge(v: 0, w: 7, weight: 0.16),
            WeightedEdge(v: 2, w: 3, weight: 0.17),
            WeightedEdge(v: 1, w: 7, weight: 0.19),
            WeightedEdge(v: 0, w: 2, weight: 0.26),
            WeightedEdge(v: 5, w: 7, weight: 0.28),
            WeightedEdge(v: 4, w: 5, weight: 0.35),
            WeightedEdge(v: 6, w: 2, weight: 0.40)
        ]
        
        let mst = mst.getMST()
        let unorderedMst = Set<WeightedEdge>(mst)
        
        XCTAssertEqual(mst.count, unorderedMst.count)
        XCTAssertEqual(unorderedMst, expected)
    }

    func testWeight() {
        addTestData()
        XCTAssertEqual(mst.getWeight(), 1.81)
    }
    
}

extension MSTTests {
    
    func addTestData() {
        graph.addEdge(v: 0, w: 2, weight: 0.26)
        graph.addEdge(v: 0, w: 4, weight: 0.38)
        graph.addEdge(v: 0, w: 7, weight: 0.16)
        graph.addEdge(v: 1, w: 2, weight: 0.36)
        graph.addEdge(v: 1, w: 3, weight: 0.29)
        graph.addEdge(v: 1, w: 5, weight: 0.32)
        graph.addEdge(v: 1, w: 7, weight: 0.19)
        graph.addEdge(v: 2, w: 3, weight: 0.17)
        graph.addEdge(v: 2, w: 7, weight: 0.34)
        graph.addEdge(v: 3, w: 6, weight: 0.52)
        graph.addEdge(v: 4, w: 5, weight: 0.35)
        graph.addEdge(v: 4, w: 7, weight: 0.37)
        graph.addEdge(v: 5, w: 7, weight: 0.28)
        graph.addEdge(v: 6, w: 0, weight: 0.58)
        graph.addEdge(v: 6, w: 2, weight: 0.40)
        graph.addEdge(v: 6, w: 4, weight: 0.93)
    }
    
}
