//
//  TwoStackQueue.swift
//  Created by hg on 11/10/2020.
//

import Foundation

public class TwoStackQueue<T> {
    
    private var pushStack: [T]
    private var popStack: [T]
    
    public init() {
        pushStack = [T]()
        popStack = [T]()
    }
    
    public var count: Int { pushStack.count + popStack.count }
    
    public var isEmpty: Bool { pushStack.isEmpty && popStack.isEmpty }
    
    public func enqueue(_ element: T) {
        pushStack.append(element)
    }
    
    public func dequeue() -> T? {
        if isEmpty { return nil }
        if popStack.isEmpty { movePushToPop() }
        return popStack.popLast()
    }
    
    public func peek() -> T? {
        if isEmpty { return nil }
        if popStack.isEmpty { movePushToPop() }
        return popStack.last
    }
    
    private func movePushToPop() {
        while let element = pushStack.popLast() {
            popStack.append(element)
        }
    }
    
}
