//
//  MSTTestSuite.swift
//  Created by hg on 13/03/2022.
//

import XCTest
@testable import SwiftAlgorithms

class MSTTestSuite: XCTestSuite {
    
    private let suts: [(EdgeWeightedGraph) -> MST] = [
        { KruskalMST(graph: $0) },
        { LazyPrimMST(graph: $0) },
        { PrimMST(graph: $0) },
        { BoruvkaMST(graph: $0) }
    ]
    
    init() {
        super.init(name: NSStringFromClass(MSTTests.self))
        
        for sut in suts {
            for invocation in MSTTests.testInvocations {
                let newTestCase = MSTTests(invocation: invocation)
                newTestCase.createSut = sut
                addTest(newTestCase)
            }
        }
    }
    
}
