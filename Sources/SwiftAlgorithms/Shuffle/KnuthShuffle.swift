//
//  KnuthShuffle.swift
//  Created by hg on 15/10/2020.
//

import Foundation

class KnuthShuffle: Shuffle {
    
    public init() {}
    
    func shuffle<T>(_ array: inout [T]) {
        let count = array.count
        for i in 0..<count {
            let randomNumber = Int.random(in: 0...i)
            array.swapAt(i, randomNumber)
        }
    }
    
}
