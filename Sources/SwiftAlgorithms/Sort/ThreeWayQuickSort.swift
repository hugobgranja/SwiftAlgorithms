//
//  ThreeWayQuickSort.swift
//  Created by hg on 06/11/2020.
//

import Foundation

public class ThreeWayQuickSort: Sort {
    
    let partition: ThreeWayPartition
    
    public init() {
        self.partition = ThreeWayPartition()
    }
    
    public func sort<T: Comparable>(_ array: inout [T]) {
        array.shuffle()
        sort(&array, 0, array.count - 1)
    }
    
    private func sort<T: Comparable>(_ array: inout [T], _ low: Int, _ high: Int) {
        guard high > low else { return }
        let (lt, gt) = partition.partition(&array, low, high)
        sort(&array, low, lt - 1)
        sort(&array, gt + 1, high)
    }
    
}
