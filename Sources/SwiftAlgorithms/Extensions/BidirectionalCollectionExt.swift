//
//  BidirectionalCollectionExt.swift
//  Created by hg on 11/04/2022.
//

import Foundation

extension BidirectionalCollection where Element == Character {
    
    func charAt(_ offset: Int) -> Character {
        let strIndex = index(startIndex, offsetBy: offset)
        return self[strIndex]
    }
    
    func asciiValue(at offset: Int) -> Int? {
        return charAt(offset).asciiValue.map { Int($0) }
    }
    
}
