//
//  SelectTestSuite.swift
//  Created by hg on 15/02/2022.
//

import XCTest
@testable import SwiftAlgorithms

class SelectTestSuite: XCTestSuite {
    
    private let suts: [() -> Select] = [{ QuickSelect() }, { ThreeWayQuickSelect() }]
    
    init() {
        super.init(name: NSStringFromClass(SelectTests.self))
        
        for sut in suts {
            for invocation in SelectTests.testInvocations {
                let newTestCase = SelectTests(invocation: invocation)
                newTestCase.createSut = sut
                addTest(newTestCase)
            }
        }
    }
    
}
