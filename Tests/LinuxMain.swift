import XCTest

import SwiftAlgorithmsTests

var tests = [XCTestCaseEntry]()
tests += UnionFindTests.allTests()
tests += LinkedListTests.allTests()
tests += StackTests.allTests()
tests += QueueTests.allTests()
tests += PartitionTests.allTests()
tests += ThreeWayPartitionTests.allTests()
tests += SortingTests.allTests()
tests += SelectTests.allTests()
XCTMain(tests)
