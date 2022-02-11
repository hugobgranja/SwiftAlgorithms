//
//  MergeSort.swift
//  Created by hg on 17/10/2020.
//

import Foundation

public class MergeSort: Sort {
    
    public init() {}
    
    public func sort<T: Comparable>(_ array: inout [T]) {
        sort(&array, 0, array.count - 1)
    }
    
    private func sort<T: Comparable>(_ array: inout [T], _ low: Int, _ high: Int) {
        guard high > low else { return }
        let mid = low + (high - low) / 2
        sort(&array, low, mid)
        sort(&array, mid + 1, high)
        merge(&array, low, mid, high)
    }
    
    private func merge<T: Comparable>(_ a: inout [T], _ low: Int, _ mid: Int, _ high: Int) {
        let left = [T](a[low...mid])
        let right = [T](a[mid+1...high])
        
        var i = 0, j = 0
        for k in low...high {
            if i >= left.count {
                a[k] = right[j]
                j += 1
            }
            else if j >= right.count {
                a[k] = left[i]
                i += 1
            }
            else if right[j] < left[i] {
                a[k] = right[j]
                j += 1
            }
            else {
                a[k] = left[i]
                i += 1
            }
        }
    }
    
}
