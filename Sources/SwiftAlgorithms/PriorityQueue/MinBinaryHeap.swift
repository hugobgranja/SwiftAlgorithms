//
//  MinBinaryHeap.swift
//  Created by hg on 26/12/2020.
//

import Foundation

public class MinBinaryHeap<T>: BinaryHeap<T> where T: Comparable {
    
    public init() {
        super.init(isLowerPriority: { $0 > $1 })
    }
    
}
