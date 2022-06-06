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
    private let pattern: [Character]
    private var bcSkip: [Int]
    
    public init(pattern: [Character]) {
        self.radix = 128
        self.pattern = pattern
        self.bcSkip = [Int](repeating: -1, count: radix)
        buildBadCharSkip()
    }
    
    private func buildBadCharSkip() {
        for (index, char) in pattern.enumerated() {
            let value = Int(char.asciiValue!)
            bcSkip[value] = index
        }
    }
    
    public func search(_ text: [Character]) -> Int? {
        var i = 0
        
        while i < text.count - pattern.count {
            var skip = 0
            var j = pattern.count - 1
            var mismatchFound = false
            
            while j >= 0 && !mismatchFound {
                let patternCharValue = Int(pattern[j].asciiValue!)
                let textCharValue = Int(text[i + j].asciiValue!)
                
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
