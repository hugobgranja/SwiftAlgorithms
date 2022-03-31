//
//  ThreeWayRadixQSort.swift
//  Created by hg on 31/03/2022.
//

import Foundation

public class ThreeWayRadixQSort {
    
    let cutOffToInsertionSort: Int
    
    public init() {
        self.cutOffToInsertionSort = 15
    }
    
    public func sort(_ array: inout [String]) {
        array.shuffle()
        sort(&array, 0, array.count - 1, 0)
    }
    
    private func sort(_ array: inout [String], _ low: Int, _ high: Int, _ d: Int) {
        guard high > low else { return }
        
        if high <= low + cutOffToInsertionSort {
            insertionSort(&array, low: low, high: high, d: d)
            return
        }
        
        let (lt, gt) = partition(&array, low, high, d)
        sort(&array, low, lt - 1, d)
        if charAt(array[low], d) >= "\0" { sort(&array, lt, gt, d + 1) }
        sort(&array, gt + 1, high, d)
    }
    
    private func insertionSort(_ array: inout [String], low: Int, high: Int, d: Int) {
        for i in low...high {
            var j = i
            while j > low && array[j].dropFirst(d) < array[j - 1].dropFirst(d) {
                array.swapAt(j, j - 1)
                j -= 1
            }
        }
    }
    
    private func partition(_ array: inout [String], _ low: Int, _ high: Int, _ d: Int) -> (Int, Int) {
        var lt = low, i = low + 1, gt = high
        let v = charAt(array[low], d)
        
        while i <= gt {
            let t = charAt(array[i], d)
            if t < v {
                array.swapAt(lt, i)
                lt += 1
                i += 1
            }
            else if t > v {
                array.swapAt(i, gt)
                gt -= 1
            }
            else {
                i += 1
            }
        }
        
        return (lt, gt)
    }
    
    private func charAt(_ str: String, _ index: Int) -> Character {
        guard index < str.count else { return "\0" }
        let strIndex = str.index(str.startIndex, offsetBy: index)
        return str[strIndex]
    }
    
}
