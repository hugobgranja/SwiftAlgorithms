//
//  InsertionSort.swift
//  Created by hg on 13/10/2020.
//

import Foundation

public class InsertionSort: Sort {
    
    public init() {}
    
    public func sort<T: Comparable>(_ array: inout [T]) {
        let count = array.count
        for i in 0..<count {
            var j = i
            while j > 0 && array[j] < array[j - 1]  {
                array.swapAt(j, j - 1)
                j -= 1
            }
        }
    }
    
}
