//
//  BinaryDataBuilder.swift
//  Created by hg on 16/04/2022.
//

import Foundation

public class BinaryDataBuilder {
    
    private var data: Data
    private var buffer: UInt8
    private var bufferCount: UInt8
    
    public init() {
        self.data = Data()
        self.buffer = 0
        self.bufferCount = 0
    }
    
    public func append(bit: Bool) {
        buffer <<= 1
        if bit { buffer |= 1 }
        
        bufferCount += 1
        if bufferCount == 8 { clearBuffer() }
    }
    
    public func append(byte: UInt8) {
        if bufferCount == 0 {
            data.append(byte)
        }
        else {
            for i in 0..<8 {
                let bit = ((byte >> (8 - i - 1)) & 1) == 1
                append(bit: bit)
            }
        }
    }
    
    public func append(_ integer: Int64) {
        append(byte: UInt8((integer >> 56) & 0xFF))
        append(byte: UInt8((integer >> 48) & 0xFF))
        append(byte: UInt8((integer >> 40) & 0xFF))
        append(byte: UInt8((integer >> 32) & 0xFF))
        append(byte: UInt8((integer >> 24) & 0xFF))
        append(byte: UInt8((integer >> 16) & 0xFF))
        append(byte: UInt8((integer >> 8) & 0xFF))
        append(byte: UInt8((integer >> 0) & 0xFF))
    }
    
    public func append(_ integer: Int, bitWidth: Int) {
        guard bitWidth > 0 && bitWidth <= 64 else { return }
        guard integer < (1 << bitWidth) else { return }
        
        if bitWidth == 64 {
            append(Int64(integer))
        }
        else {
            for i in 0..<bitWidth {
                let bit = ((integer >> (bitWidth - i - 1)) & 1) == 1
                append(bit: bit)
            }
        }
    }
    
    public func getData() -> Data {
        clearBuffer()
        return data
    }
    
    private func clearBuffer() {
        guard bufferCount > 0 else { return }
        buffer <<= 8 - bufferCount
        data.append(buffer)
        buffer = 0
        bufferCount = 0
    }
    
}
