//
//  SortTestSuite.swift
//  Created by hg on 15/02/2022.
//

import XCTest
@testable import SwiftAlgorithms

class SortTestSuite: XCTestSuite {
    
    private let suts: [() -> Sort] = [
        { HeapSort() },
        { InsertionSort() },
        { MergeSort() },
        { QuickSort() },
        { ShellSort() },
        { ThreeWayQuickSort() }
    ]
    
    init() {
        super.init(name: NSStringFromClass(SortTests.self))
        
        for sut in suts {
            for invocation in SortTests.testInvocations {
                let newTestCase = SortTests(invocation: invocation)
                newTestCase.createSut = sut
                addTest(newTestCase)
            }
        }
    }
    
}
