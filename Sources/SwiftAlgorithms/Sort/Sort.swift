//
//  Sort.swift
//  Created by hg on 13/10/2020.
//

import Foundation

public protocol Sort {
    
    func sort<T: Comparable>(_ array: inout [T])

}
