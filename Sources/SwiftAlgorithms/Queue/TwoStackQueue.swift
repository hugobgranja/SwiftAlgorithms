//
//  TwoStackQueue.swift
//  Created by hg on 11/10/2020.
//

import Foundation

public class TwoStackQueue<T> {
    
    private var pushStack: ArrayStack<T>
    private var popStack: ArrayStack<T>
    
    public init() {
        pushStack = ArrayStack<T>()
        popStack = ArrayStack<T>()
    }
    
    public var count: Int { pushStack.count + popStack.count }
    
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
    
    private func movePushToPop() {
        while let element = pushStack.pop() {
            popStack.push(element)
        }
    }
    
}
