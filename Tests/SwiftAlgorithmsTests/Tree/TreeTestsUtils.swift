//
//  TreeTestsUtils.swift
//  Created by hg on 15/02/2022.
//

import XCTest
@testable import SwiftAlgorithms

struct TreeTestsUtils {
    
    func checkPairs<K: Equatable, V: Equatable>(
        result: [(K, V)],
        expectation: [(K, V)],
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let resultKeys = result.map { $0.0 }
        let expectationKeys = expectation.map { $0.0 }
        
        let resultValues = result.map { $0.1 }
        let expectationValues = expectation.map { $0.1 }
        
        XCTAssertEqual(resultKeys, expectationKeys, file: file, line: line)
        XCTAssertEqual(resultValues, expectationValues, file: file, line: line)
    }
    
}
