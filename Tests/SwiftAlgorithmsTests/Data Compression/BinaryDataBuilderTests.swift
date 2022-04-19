//
//  BinaryDataBuilderTests.swift
//  Created by hg on 16/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class BinaryDataBuilderTests: XCTestCase {
    
    var sut: BinaryDataBuilder!
    
    override func setUp() {
        super.setUp()
        sut = BinaryDataBuilder()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testAppendBits() {
        let bits = [true, false, true, true, false, true, false, false]
        let expected = Data([180])
        
        for bit in bits {
            sut.append(bit: bit)
        }
        
        XCTAssertEqual(sut.getData(), expected)
    }
    
    func testAppendByte() {
        let bytes = Data([4,180,255])
        
        for byte in bytes {
            sut.append(byte: byte)
        }
        
        XCTAssertEqual(sut.getData(), bytes)
    }
    
    func testAppendBitsAndBytes() {
        [true, false, true, true, false, true].forEach {
            sut.append(bit: $0)
        }
        
        sut.append(byte: 180)
        sut.append(bit: false)
        sut.append(bit: false)
        
        let expected = Data([182, 208])
        
        XCTAssertEqual(sut.getData(), expected)
    }
    
    func testAppendInt64() {
        sut.append(Int64.max)
        let expected = Data([127, 255, 255, 255, 255, 255, 255, 255])
        XCTAssertEqual(sut.getData(), expected)
    }
    
    func testAppendBitsAndInt64() {
        [true, false, true, true, false, true].forEach {
            sut.append(bit: $0)
        }
        
        sut.append(2147450878)
        sut.append(bit: false)
        sut.append(bit: false)
        
        let expected = Data([180, 0, 0, 0, 1, 255, 253, 255, 248])
        
        XCTAssertEqual(sut.getData(), expected)
    }
    
    func testAppendIntWithBitCount() {
        sut.append(1, bitWidth: 2)
        var data = sut.getData()
        XCTAssertEqual(data, Data([64]))
        XCTAssertEqual(data.count, 1)
        
        sut.append(2, bitWidth: 10)
        data = sut.getData()
        XCTAssertEqual(data, Data([64, 0, 128]))
        XCTAssertEqual(data.count, 3)
    }

}
