//
//  Select.swift
//  Created by hg on 06/11/2020.
//

import Foundation

public protocol Select {
    
    func select<T: Comparable>(_ a: inout [T], k: Int) -> T?
    
}
