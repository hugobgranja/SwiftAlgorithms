//
//  PriorityQueueTests.swift
//  
//
//  Created by hg on 23/12/2020.
//

import XCTest
@testable import SwiftAlgorithms

final class PriorityQueueTests: XCTestCase {
    
    var pq: MaxBinaryHeap<Int>!
    
    override func setUp() {
        super.setUp()
        pq = MaxBinaryHeap()
    }
    
    override func tearDown() {
        super.tearDown()
        pq = nil
    }
    
    func testOne() {
        let a = [20,19,18,14,16,15,1,5,9,7,8]
        a.forEach { pq.enqueue($0) }
        
        let asorted = a.sorted { $0 > $1 }
        for element in asorted {
            XCTAssertEqual(pq.dequeue(), element)
        }
    }
    
    func testTwo() {
        let a = [77,37,100,13,49,97,19,88,15,73,58,9,12,98,97,14,4,95]
        a.forEach { pq.enqueue($0) }
        
        let asorted = a.sorted { $0 > $1 }
        for element in asorted {
            XCTAssertEqual(pq.dequeue(), element)
        }
    }
    
    func testRandom() {
        let tries = 100
        let maxSize = 20
        let maxNumber = 100

        for _ in 0...tries {
            let aSize = Int.random(in: 1...maxSize)
            var a = [Int]()
            
            for _ in 0..<aSize {
                let element = Int.random(in: 0...maxNumber)
                a.append(element)
                pq.enqueue(element)
            }
            
            let asorted = a.sorted { $0 > $1 }
            
            for element in asorted {
                XCTAssertEqual(pq.dequeue(), element)
            }
        }
    }

    static var allTests = [
        ("testOne", testOne),
        ("testTwo", testTwo)
    ]
}
