//
//  QuickSelect.swift
//  Created by hg on 06/11/2020.
//

import Foundation

public class QuickSelect: Select {
    
    let partition: Partition
    
    public init() {
        self.partition = HoarePartition()
    }
    
    public func select<T: Comparable>(_ a: inout [T], k: Int) -> T? {
        guard k < a.count else { return nil }
        
        a.shuffle()
        var low = 0, high = a.count - 1
        
        while high > low {
            let j = partition.partition(&a, low, high)
            if j < k { low = j + 1 }
            else if j > k { high = j - 1 }
            else { return a[k] }
        }
        
        return a[k]
    }
    
}
