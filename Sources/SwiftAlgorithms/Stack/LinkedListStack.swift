//
//  LinkedListStack.swift
//  Created by hg on 11/10/2020.
//

import Foundation

public class LinkedListStack<T> {
 
    private var elements: SinglyLinkedList<T>
    
    public init() {
        elements = SinglyLinkedList<T>()
    }
    
    public var count: Int { elements.count }
    
    public func push(_ element: T) {
        elements.prepend(element)
    }
    
    public func pop() -> T? {
        return elements.removeFirst()
    }
    
    public func peek() -> T? {
        return elements.first()
    }
    
    public func isEmpty() -> Bool {
        return elements.isEmpty()
    }
    
}
