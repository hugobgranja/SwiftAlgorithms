//
//  PartitionTestSuite.swift
//  Created by hg on 13/02/2022.
//

import XCTest
@testable import SwiftAlgorithms

class PartitionTestSuite: XCTestSuite {
    
    private let suts: [() -> Partition] = [{ HoarePartition() }, { LomutoPartition() }]
    
    init() {
        super.init(name: NSStringFromClass(PartitionTests.self))
        
        for sut in suts {
            for invocation in PartitionTests.testInvocations {
                let newTestCase = PartitionTests(invocation: invocation)
                newTestCase.createSut = sut
                addTest(newTestCase)
            }
        }
    }
    
}
