//
//  BooyerMoore.swift
//  Created by hg on 07/04/2022.
//
//  Boyer-Moore algorithm.
//
//  ~ N / M character compares.
//  ~ MN worst case without KMP-like rule to guard against repetitive patterns.
//  O(R) space.
//

import Foundation

public class BoyerMoore {
    
    private let radix: Int
    private let pattern: String
    private var bcSkip: [Int]
    
    public init(pattern: String) {
        self.radix = 128
        self.pattern = pattern
        self.bcSkip = [Int](repeating: -1, count: radix)
        buildBadCharSkip()
    }
    
    private func buildBadCharSkip() {
        for index in 0..<pattern.count {
            let value = asciiValue(of: pattern, at: index)
            bcSkip[value] = index
        }
    }
    
    private func asciiValue(of string: String, at index: Int) -> Int {
        let strIndex = string.index(string.startIndex, offsetBy: index)
        return Int(string[strIndex].asciiValue!)
    }
    
    public func search(_ text: String) -> Int? {
        var i = 0
        
        while i < text.count - pattern.count {
            var skip = 0
            var j = pattern.count - 1
            var mismatchFound = false
            
            while j >= 0 && !mismatchFound {
                let patternCharValue = asciiValue(of: pattern, at: j)
                let textCharValue = asciiValue(of: text, at: i + j)
                
                if patternCharValue != textCharValue {
                    skip = max(1, j - bcSkip[textCharValue])
                    mismatchFound = true
                }
                
                j -= 1
            }
            
            if skip == 0 { return i }
            i += skip
        }
        
        return nil
    }
    
}
