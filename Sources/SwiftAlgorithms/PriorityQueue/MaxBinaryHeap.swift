//
//  MaxBinaryHeap.swift
//  Created by hg on 26/12/2020.
//

import Foundation

public class MaxBinaryHeap<T>: BinaryHeap<T> where T: Comparable {
    
    public init() {
        super.init(isLowerPriority: { $0 < $1 })
    }
    
}
