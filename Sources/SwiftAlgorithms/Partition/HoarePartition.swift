//
//  HoarePartition.swift
//  Created by hg on 06/11/2020.
//

import Foundation

public class HoarePartition: Partition {
    
    public init() {}
    
    public func partition<T: Comparable>(_ array: inout [T], _ low: Int, _ high: Int) -> Int {
        var i = low
        var j = high + 1
        
        while true {
            repeat { i += 1 } while array[i] < array[low] && i != high
            repeat { j -= 1 } while array[low] < array[j] && j != low
            if i >= j { break }
            array.swapAt(i, j)
        }
        
        array.swapAt(low, j)
        return j
    }
    
}
