//
//  SortUtil.swift
//  Created by hg on 01/04/2022.
//

import Foundation

class SortUtil {
    
    static func isSorted<T: Comparable>(_ array: [T]) -> Bool {
        var i = 1
        while i < array.count {
            if array[i] < array[i - 1] { return false }
            i += 1
        }
        return true
    }
    
}
