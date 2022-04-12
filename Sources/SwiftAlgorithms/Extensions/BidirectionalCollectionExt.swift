//
//  BidirectionalCollectionExt.swift
//  Created by hg on 11/04/2022.
//

import Foundation

extension BidirectionalCollection where Element == Character {
    
    subscript(offset: Int) -> Character {
        get {
            return self[index(startIndex, offsetBy: offset)]
        }
    }
    
    func asciiValue(at offset: Int) -> Int? {
        return self[offset].asciiValue.map { Int($0) }
    }
    
}
