//
//  Queue.swift
//  Created by hg on 11/10/2020.
//

import Foundation

public protocol Queue {
    
    associatedtype T
    
    func enqueue(_ element: T)
    func dequeue() -> T?
    func peek() -> T?
    func isEmpty() -> Bool
    func size() -> Int
    
}
