//
//  BinaryDataReaderTests.swift
//  Created by hg on 16/04/2022.
//

import XCTest
@testable import SwiftAlgorithms

class BinaryDataReaderTests: XCTestCase {
    
    func testReadBit() {
        let data = Data([180])
        let expectedRead = [true, false, true, true, false, true, false, false]
        let reader = BinaryDataReader(data: data)
        
        for i in 0..<8 {
            let bit = reader.readBit()
            XCTAssertEqual(bit, expectedRead[i])
        }
    }
    
    func testReadAlignedByte() {
        let data = Data([180])
        let reader = BinaryDataReader(data: data)
        XCTAssertEqual(reader.readByte(), 180)
    }
    
    func testReadNonAlignedByte() {
        let byte: UInt8 = 128
        
        let builder = BinaryDataBuilder()
        builder.append(bit: true)
        builder.append(byte: byte)
        
        let reader = BinaryDataReader(data: builder.getData())
        _ = reader.readBit()
        
        XCTAssertEqual(reader.readByte(), byte)
    }
    
    func testReadInt64() {
        let data = Data([127, 255, 255, 255, 255, 255, 255, 255])
        let reader = BinaryDataReader(data: data)
        XCTAssertEqual(reader.readInt64(), Int64.max)
    }
    
    func testReadIntWithBitCount() {
        let data = Data([128, 110])
        let reader = BinaryDataReader(data: data)
        XCTAssertEqual(reader.readInt(bitWidth: 12), 2054)
        XCTAssertEqual(reader.readInt(bitWidth: 4), 14)
    }

}
