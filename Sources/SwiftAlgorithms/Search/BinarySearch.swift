//
//  BinarySearch.swift
//  Created by hg on 18/10/2020.
//

import Foundation

public class BinarySearch {
    
    public init() {}
    
    public func indexOf<T: Comparable>(_ array: [T], _ element: T) -> Int? {
        return indexOf(array, element, 0, array.count - 1)
    }
    
    public func indexOf<T: Comparable>(_ array: [T], _ element: T, _ low: Int, _ high: Int) -> Int? {
        var low = low, high = high
        
        while low <= high {
            let mid = low + (high - low) / 2
            if element < array[mid] { high = mid - 1 }
            else if element > array[mid] { low = mid + 1 }
            else { return mid }
        }
        
        return nil
    }
    
    public func indexOfIt<T: Comparable>(_ array: [T], _ element: T) -> Int? {
        var lowerBound = 0
        var upperBound = array.count
        
        while lowerBound < upperBound {
            let mid = lowerBound + (upperBound - lowerBound) / 2
            
            if element < array[mid] {
                upperBound = mid
            } else if element > array[mid] {
                lowerBound = mid + 1
            } else {
                return mid
            }
        }
        
        return nil
    }
    
}
