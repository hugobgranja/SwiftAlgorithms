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
        let firstCharValue = Int(pattern.first!.asciiValue!)
        dfa[firstCharValue][0] = 1
        var mismatchState = 0
        
        for (state, char) in zip(1..<pattern.count, pattern.dropFirst()) {
            for radixChar in 0..<radix {
                dfa[radixChar][state] = dfa[radixChar][mismatchState]
            }
            
            let charValue = Int(char.asciiValue!)
            dfa[charValue][state] = state + 1
            mismatchState = dfa[charValue][mismatchState]
        }
    }
    
    public func search<T: StringProtocol>(_ text: T) -> String.Index? {
        var index = text.startIndex
        var j = 0
        
        while index < text.endIndex && j < patternLength {
            let charValue = Int(text[index].asciiValue!)
            j = dfa[charValue][j]
            index = text.index(after: index)
        }
        
        if j == patternLength {
            return text.index(index, offsetBy: -patternLength)
        }
        
        return nil
    }
    
}
