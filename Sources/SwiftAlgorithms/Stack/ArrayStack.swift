//
//  ArrrayStack.swift
//  Created by hg on 11/10/2020.
//

import Foundation

public struct ArrayStack<T> {
    
    private(set) var elements: [T]
    
    public init() {
        elements = [T]()
    }
    
    public init(_ array: [T]) {
        elements = array
    }
    
    public var count: Int { elements.count }
    
    public mutating func push(_ element: T) {
        elements.append(element)
    }
    
    public mutating func push(contentsOf array: [T]) {
        elements.append(contentsOf: array)
    }
    
    public mutating func pop() -> T? {
        return elements.popLast()
    }
    
    public func peek() -> T? {
        return elements.last
    }
    
    public func isEmpty() -> Bool {
        return elements.isEmpty
    }
    
}
