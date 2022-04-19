//
//  BinaryDataReader.swift
//  Created by hg on 16/04/2022.
//

import Foundation

public class BinaryDataReader {
    
    private let data: Data
    private var buffer: UInt8?
    private var bufferCount: UInt8
    private var currentByte: Int
    
    public init(data: Data) {
        self.data = data
        self.bufferCount = 0
        self.currentByte = 0
        fillBuffer()
    }
    
    public func readBit() -> Bool? {
        guard let buffer = buffer else { return nil }
        bufferCount -= 1
        let bit = ((buffer >> bufferCount) & 1) == 1
        if bufferCount == 0 { fillBuffer() }
        return bit
    }
    
    public func readByte() -> UInt8? {
        guard let buffer = buffer else { return nil }
        
        if bufferCount == 8 {
            let byte = buffer
            fillBuffer()
            return byte
        }
        
        var byte = buffer
        byte <<= 8 - bufferCount
        let prevBufferCount = bufferCount
        fillBuffer()
        guard let buffer = self.buffer else { return nil }
        bufferCount = prevBufferCount
        byte |= buffer >> bufferCount
        return byte
    }
    
    public func readInt64() -> Int64? {
        var integer: Int64 = 0
        
        for _ in 0..<8 {
            guard let byte = readByte() else { return nil }
            integer <<= 8
            integer |= Int64(byte)
        }
        
        return integer
    }
    
    public func readInt(bitWidth: Int) -> Int? {
        guard bitWidth > 0 && bitWidth <= Int.bitWidth else { return nil }
        
        if bitWidth == 64 && Int.bitWidth == 64 {
            return readInt64().map { Int($0) }
        }
        
        var integer = 0
        for _ in 0..<bitWidth {
            integer <<= 1
            guard let bit = readBit() else { return nil }
            if bit { integer |= 1 }
        }
        
        return integer
    }
    
    private func fillBuffer() {
        if currentByte < data.count {
            buffer = data[currentByte]
            bufferCount = 8
            currentByte += 1
        }
        else {
            buffer = nil
        }
    }
    
}
