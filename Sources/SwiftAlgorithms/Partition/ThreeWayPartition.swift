//
//  ThreeWayPartition.swift
//  Created by hg on 06/11/2020.
//

import Foundation

public class ThreeWayPartition {
    
    public init() {}
    
    public func partition<T: Comparable>(_ array: inout [T], _ low: Int, _ high: Int) -> (Int, Int) {
        var lt = low, i = low, gt = high
        let v = array[low]
        
        while i <= gt {
            if array[i] < v {
                array.swapAt(lt, i)
                lt += 1
                i += 1
            }
            else if array[i] > v {
                array.swapAt(i, gt)
                gt -= 1
            }
            else {
                i += 1
            }
        }
        
        return (lt, gt)
    }
    
}
