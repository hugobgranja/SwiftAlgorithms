//
//  SCCTestSuite.swift
//  Created by hg on 15/02/2022.
//

import XCTest
@testable import SwiftAlgorithms

class SCCTestSuite: XCTestSuite {
    
    private let suts: [(Digraph) -> SCC] = [
        { KosarajuSharirSCC(graph: $0) },
        { TarjanSCC(graph: $0) },
        { GabowSCC(graph: $0) }
    ]
    
    init() {
        super.init(name: NSStringFromClass(SCCTests.self))
        
        for sut in suts {
            for invocation in SCCTests.testInvocations {
                let newTestCase = SCCTests(invocation: invocation)
                newTestCase.createSut = sut
                addTest(newTestCase)
            }
        }
    }
    
}
