//
//  PriorityQueue.swift
//  Created by hg on 22/12/2020.
//

import Foundation

public protocol PriorityQueue {
    
    associatedtype T
    
    var count: Int { get }
    func enqueue(_ element: T)
    func dequeue() -> T?
    func peek() -> T?
    func isEmpty() -> Bool
    
}
