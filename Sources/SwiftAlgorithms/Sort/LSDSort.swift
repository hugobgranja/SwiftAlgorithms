//
//  LSDSort.swift
//  Created by hg on 30/03/2022.
//
//  O(2 W N) time.
//  O(N + R) space.
//  Stable.
//  W = key length, R = radix, N = number of keys.
//


import Foundation

public class LSDSort {
    
    public init() {}
    
    public func sortASCII(_ array: inout [String], charCount: Int) {
        let radix = 128
        var aux = [String](repeating: "", count: array.count)
        
        for d in (0..<charCount).reversed() {
            var count = [Int](repeating: 0, count: radix + 1)
            
            for i in 0..<array.count {
                let value = asciiValue(of: array[i], at: d)!
                count[value + 1] += 1
            }
            
            for i in 0..<radix {
                count[i + 1] += count[i]
            }
            
            for i in 0..<array.count {
                let value = asciiValue(of: array[i], at: d)!
                aux[count[value]] = array[i]
                count[value] += 1
            }
            
            for i in 0..<array.count {
                array[i] = aux[i]
            }
        }
    }
    
    private func asciiValue(of string: String, at index: Int) -> Int? {
        let strIndex = string.index(string.startIndex, offsetBy: index)
        return string[strIndex].asciiValue.map { Int($0) }
    }
    
    public func sort(_ array: inout [Int]) {
        let bitsPerByte = 8
        let w = Int.bitWidth / bitsPerByte
        let radix = 1 << bitsPerByte
        let mask = radix - 1
        var aux = [Int](repeating: 0, count: array.count)
        
        for d in 0..<w {
            var count = [Int](repeating: 0, count: radix + 1)
            
            for i in 0..<array.count {
                let c = (array[i] >> (bitsPerByte * d)) & mask
                count[c + 1] += 1
            }
            
            for i in 0..<radix {
                count[i + 1] += count[i]
            }
            
            // For most significant byte, 0x80-0xFF comes before 0x00-0x7F
            // Because of signed number representation
            if d == w - 1 {
                let halfRadix = radix/2
                let shift1 = count[radix] - count[halfRadix]
                let shift2 = count[halfRadix]
                
                for i in 0..<halfRadix {
                    count[i] += shift1
                }
                
                for i in halfRadix..<radix {
                    count[i] -= shift2
                }
            }
            
            for i in 0..<array.count {
                let c = (array[i] >> (bitsPerByte * d)) & mask
                aux[count[c]] = array[i]
                count[c] += 1
            }
            
            for i in 0..<array.count {
                array[i] = aux[i]
            }
        }
    }
    
}
