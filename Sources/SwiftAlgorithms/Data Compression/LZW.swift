//
//  LZW.swift
//  Created by hg on 19/04/2022.
//

import Foundation

public class LZW {
    
    private let radix: Int
    private let maxCodewords: Int
    private let codewordWidth: Int
    
    init() {
        self.radix = 128
        self.maxCodewords = 4096
        self.codewordWidth = 12
    }
    
    public func compress(_ string: String) -> Data {
        if string.isEmpty { return Data() }
        
        let tst = TST<Int>()
        
        for i in 0..<radix {
            let char = String(UnicodeScalar(i)!)
            tst.insert(key: char, value: Int(i))
        }
        
        let builder = BinaryDataBuilder()
        var codeCount = radix + 1
        var index = string.count
        
        while index > 0 {
            let suffix = string.suffix(index)
            let longestPrefix = tst.longestPrefix(of: suffix)!
            builder.append(tst.get(key: longestPrefix)!, bitWidth: codewordWidth)
            
            if longestPrefix.count < suffix.count && codeCount < maxCodewords {
                let newCodeword = suffix.prefix(longestPrefix.count + 1)
                tst.insert(key: newCodeword, value: codeCount)
                codeCount += 1
            }
            
            index -= longestPrefix.count
        }
        
        builder.append(radix, bitWidth: codewordWidth)
        return builder.getData()
    }
    
    public func expand(data: Data) -> String? {
        var table = (0..<radix).map { String(UnicodeScalar($0)!) }
        table.append("")
        
        let reader = BinaryDataReader(data: data)
        var string = ""
        var word = ""
        
        while let codeword = reader.readInt(bitWidth: 12), codeword != radix {
            if codeword == table.count {
                table.append(word + word.prefix(1))
            }
            else if !word.isEmpty && table.count < maxCodewords {
                table.append(word + table[codeword].prefix(1))
            }
            
            word = table[codeword]
            string += word
        }
        
        return string
    }
    
}
