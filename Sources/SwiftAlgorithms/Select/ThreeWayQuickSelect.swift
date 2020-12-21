//
//  ThreeWayQuickSelect.swift
//  Created by hg on 20/12/2020.
//

import Foundation

public class ThreeWayQuickSelect: Select {
    
    let partition: ThreeWayPartition
    
    public init() {
        self.partition = ThreeWayPartition()
    }
    
    public func select<T: Comparable>(_ a: inout [T], k: Int) -> T? {
        guard k < a.count else { return nil }
        
        a.shuffle()
        var low = 0, high = a.count - 1
        
        while high > low {
            let (lt, gt) = partition.partition(&a, low, high)
            if gt < k { low = gt + 1 }
            else if lt > k { high = lt - 1 }
            else { return a[k] }
        }
        
        return a[k]
    }
    
}
