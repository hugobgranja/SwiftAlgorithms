//
//  UnionFindTestSuite.swift
//  Created by hg on 15/02/2022.
//

import XCTest
@testable import SwiftAlgorithms

class UnionFindTestSuite: XCTestSuite {
    
    private let suts: [() -> UnionFind] = [
        { try! QuickFindUF(length: 10) },
        { try! QuickUnionUF(length: 10) },
        { try! WeightedQuickUnionUF(length: 10) }
    ]
    
    init() {
        super.init(name: NSStringFromClass(UnionFindTests.self))
        
        for sut in suts {
            for invocation in UnionFindTests.testInvocations {
                let newTestCase = UnionFindTests(invocation: invocation)
                newTestCase.createSut = sut
                addTest(newTestCase)
            }
        }
    }
    
}
