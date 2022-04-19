//
//  RunLength.swift
//  Created by hg on 15/04/2022.
//
//  Uses 8-bit run lengths.
//

import Foundation

public class RunLength {
    
    private let radix: Int
    
    public init() {
        self.radix = 256
    }
    
    public func compress(data: Data) -> Data {
        let reader = BinaryDataReader(data: data)
        let builder = BinaryDataBuilder()
        var currentBit = false
        var run: UInt8 = 0
        
        while let bit = reader.readBit() {
            if bit == currentBit {
                if run == radix - 1 {
                    builder.append(byte: run)
                    run = 0
                    builder.append(byte: run)
                }
                
                run += 1
            }
            else {
                builder.append(byte: run)
                run = 1
                currentBit.toggle()
            }
        }
        
        builder.append(byte: run)
        return builder.getData()
    }
    
    public func expand(data: Data) -> Data {
        let builder = BinaryDataBuilder()
        var bit = false
        
        for run in data {
            for _ in 0..<run {
                builder.append(bit: bit)
            }
            bit.toggle()
        }
        
        return builder.getData()
    }
    
}
