//
//  LinkedList.swift
//  Created by hg on 11/10/2020.
//

import Foundation

public protocol LinkedList {
    
    associatedtype T
    
    var count: Int { get }
    func append(_ element: T)
    func prepend(_ element: T)
    func removeFirst() -> T?
    func first() -> T?
    func last() -> T?
    func isEmpty() -> Bool
    
}

