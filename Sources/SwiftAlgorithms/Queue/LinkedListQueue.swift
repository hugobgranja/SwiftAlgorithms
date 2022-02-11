//
//  LinkedListQueue.swift
//  Created by hg on 11/10/2020.
//

import Foundation

public class LinkedListQueue<T>: Queue {

    private var elements: SinglyLinkedList<T>
    
    public init() {
        elements = SinglyLinkedList<T>()
    }
    
    public func enqueue(_ element: T) {
        elements.append(element)
    }
    
    public func dequeue() -> T? {
        return elements.removeFirst()
    }
    
    public func peek() -> T? {
        return elements.first()
    }
    
    public func isEmpty() -> Bool {
        return elements.isEmpty()
    }
    
    public func size() -> Int {
        return elements.size()
    }
    
    
}
