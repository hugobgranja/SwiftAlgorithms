//
//  QuickSort.swift
//  Created by hg on 17/10/2020.
//

import Foundation

public class QuickSort: Sort {
    
    let partition: Partition
    
    public init() {
        self.partition = HoarePartition()
    }
    
    public func sort<T: Comparable>(_ array: inout [T]) {
        array.shuffle()
        sort(&array, 0, array.count - 1)
    }
    
    private func sort<T: Comparable>(_ array: inout [T], _ low: Int, _ high: Int) {
        guard high > low else { return }
        let j = partition.partition(&array, low, high)
        sort(&array, low, j - 1)
        sort(&array, j + 1, high)
    }
    
}
