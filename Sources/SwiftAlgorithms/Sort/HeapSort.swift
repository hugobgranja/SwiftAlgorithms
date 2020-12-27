//
//  HeapSort.swift
//  Created by hg on 27/12/2020.
//

import Foundation

public class HeapSort: Sort {
    
    public init() {}
    
    public func sort<T: Comparable>(_ array: inout [T]) {
        var length = array.count - 1
        var k = length / 2
        
        while k >= 0 {
            sink(&array, k, length: length)
            k -= 1
        }
        
        while length > 0 {
            array.swapAt(0, length)
            length -= 1
            sink(&array, 0, length: length)
        }
    }
    
    private func sink<T: Comparable>(_ array: inout [T], _ k: Int, length: Int) {
        var k = k, leftIndex = left(k)
        
        while leftIndex < length {
            let rightIndex = right(k)
            var swapIndex = leftIndex
            
            if rightIndex < length && array[leftIndex] < array[rightIndex] { swapIndex = rightIndex }
            if array[swapIndex] < array[k] { break }
            array.swapAt(k, swapIndex)
            
            k = swapIndex
            leftIndex = left(k)
        }
    }
    
    private func parent(_ index: Int) -> Int {
        return (index - 1) / 2
    }
    
    private func left(_ index: Int) -> Int {
        return 2 * index + 1
    }
    
    private func right(_ index: Int) -> Int {
        return 2 * index + 2
    }
    
}
