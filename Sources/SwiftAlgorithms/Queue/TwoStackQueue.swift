//
//  TwoStackQueue.swift
//  Created by hg on 11/10/2020.
//

import Foundation

public class TwoStackQueue<T>: Queue {
    
    private var pushStack: ArrayStack<T>
    private var popStack: ArrayStack<T>
    
    public init() {
        pushStack = ArrayStack<T>()
        popStack = ArrayStack<T>()
    }
    
    public func enqueue(_ element: T) {
        pushStack.push(element)
    }
    
    public func dequeue() -> T? {
        if isEmpty() { return nil }
        if popStack.isEmpty() { movePushToPop() }
        return popStack.pop()
    }
    
    public func peek() -> T? {
        if isEmpty() { return nil }
        if popStack.isEmpty() { movePushToPop() }
        return popStack.peek()
    }
    
    public func isEmpty() -> Bool {
        return pushStack.isEmpty() && popStack.isEmpty()
    }
    
    public func size() -> Int {
        return pushStack.size() + popStack.size()
    }
    
    private func movePushToPop() {
        while let element = pushStack.pop() {
            popStack.push(element)
        }
    }
    
}
