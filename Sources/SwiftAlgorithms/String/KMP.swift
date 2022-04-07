//
//  KMP.swift
//  Created by hg on 06/04/2022.
//
//  Knuth-Morris-Pratt substring search.
//  O(n + mr) time worst case.
//  O(mr) space.
//  Where n is the length of the text
//  m the length of the pattern
//  r the size of the alphabet.
//

import Foundation

public class KMP {
    
    private let radix: Int
    private let patternLength: Int
    private var dfa: [[Int]]
    
    public init(pattern: String) {
        self.radix = 128
        self.patternLength = pattern.count
        self.dfa = [[Int]](
            repeating: [Int](repeating: 0, count: pattern.count),
            count: radix
        )
        
        buildDfa(for: pattern)
    }
    
    private func buildDfa(for pattern: String) {
        dfa[asciiValue(of: pattern, at: 0)][0] = 1
        var mismatchState = 0
        
        for state in 1..<pattern.count {
            for char in 0..<radix {
                dfa[char][state] = dfa[char][mismatchState]
            }
            
            let charValue = asciiValue(of: pattern, at: state)
            dfa[charValue][state] = state + 1
            mismatchState = dfa[charValue][mismatchState]
        }
    }
    
    private func asciiValue<T: StringProtocol>(of string: T, at index: Int) -> Int {
        let strIndex = string.index(string.startIndex, offsetBy: index)
        return Int(string[strIndex].asciiValue!)
    }
    
    public func search<T: StringProtocol>(_ text: T) -> Int? {
        var i = 0, j = 0
        
        while i < text.count && j < patternLength {
            let charValue = asciiValue(of: text, at: i)
            j = dfa[charValue][j]
            i += 1
        }
        
        if j == patternLength { return i - patternLength }
        
        return nil
    }
    
}
