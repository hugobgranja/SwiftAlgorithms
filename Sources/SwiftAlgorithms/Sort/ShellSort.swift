//
//  ShellSort.swift
//  Created by hg on 14/10/2020.
//

import Foundation

public class ShellSort: Sort {
    
    public init() {}
    
    public func sort<T: Comparable>(_ array: inout [T]) {
        let count = array.count
        var stride = 1
        
        while stride < count / 3 { stride = 3 * stride + 1 }
        
        while stride >= 1 {
            strideSort(&array, stride: stride)
            stride /= 3
        }
    }
    
    private func strideSort<T: Comparable>(_ array: inout [T], stride: Int) {
        let count = array.count
        var i = stride
        
        while i < count {
            var j = i
            
            while j >= stride && array[j] < array[j - stride]  {
                array.swapAt(j, j - stride)
                j -= stride
            }
            
            i += 1
        }
    }
    
}
