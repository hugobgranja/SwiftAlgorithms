//
//  RabinKarp.swift
//  Created by hg on 08/04/2022.
//

import Foundation

public class RabinKarp {
    
    private let pattern: String
    private let radix: UInt64
    private let prime: UInt64
    private var rm: UInt64! // R^(M-1) % Q
    private var patternHash: UInt64!
    
    public init(pattern: String) {
        self.pattern = pattern
        self.radix = 128
        self.prime = 2_147_483_629
        self.rm = computeRM()
        self.patternHash = hash(key: pattern)
    }
    
    private func computeRM() -> UInt64 {
        var rm: UInt64 = 1
        
        for _ in 1..<pattern.count {
            rm = (radix * rm) % prime
        }
        
        return rm
    }
    
    private func hash(key: String) -> UInt64 {
        var hash: UInt64 = 0
        
        for i in 0..<pattern.count {
            let charValue = asciiValue(of: key, at: i)
            hash = (radix * hash + charValue) % prime
        }
        
        return hash
    }

    private func asciiValue(of string: String, at index: Int) -> UInt64 {
        let strIndex = string.index(string.startIndex, offsetBy: index)
        return UInt64(string[strIndex].asciiValue!)
    }
    
    public func search(_ text: String) -> Int? {
        guard text.count >= pattern.count else { return nil }
        
        var textHash = hash(key: text)
        
        if patternHash == textHash && isMatch(text: text, from: 0) {
            return 0
        }
        
        for i in pattern.count..<text.count {
            let leadingValue = asciiValue(of: text, at: i - pattern.count)
            let currentValue = asciiValue(of: text, at: i)
            textHash = (textHash + prime - rm * leadingValue % prime) % prime
            textHash = (textHash * radix + currentValue) % prime
            
            let offset = i - pattern.count + 1
            if patternHash == textHash && isMatch(text: text, from: offset) {
                return offset
            }
        }
        
        return nil
    }
    
    private func isMatch(text: String, from start: Int) -> Bool {
        let startIndex = text.index(text.startIndex, offsetBy: start)
        let endIndex = text.index(startIndex, offsetBy: pattern.count)
        return pattern == text[startIndex..<endIndex]
    }
    
}
