//
//  LomutoPartition.swift
//  Created by hg on 06/11/2020.
//

import Foundation

public class LomutoPartition: Partition {
    
    public init() {}
    
    public func partition<T: Comparable>(_ array: inout [T], _ low: Int, _ high: Int) -> Int {
        let pivot = array[high]
        var i = low
        
        for j in low..<high {
            if array[j] <= pivot {
                array.swapAt(i, j)
                i += 1
            }
        }
        
        array.swapAt(i, high)
        return i
    }
    
}
