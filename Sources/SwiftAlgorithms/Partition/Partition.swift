//
//  Partition.swift
//  Created by hg on 06/11/2020.
//

import Foundation

protocol Partition {
 
    func partition<T: Comparable>(_ array: inout [T], _ low: Int, _ high: Int) -> Int
    
}
