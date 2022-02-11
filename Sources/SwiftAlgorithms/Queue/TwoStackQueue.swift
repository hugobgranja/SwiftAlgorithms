//
//  TwoStackQueue.swift
//  Created by hg on 11/10/2020.
//

import Foundation

public class TwoStackQueue<T>: Queue {
    
    private var stackOne: ArrayStack<T>
    private var stackTwo: ArrayStack<T>
    
    public init() {
        stackOne = ArrayStack<T>()
        stackTwo = ArrayStack<T>()
    }
    
    public func enqueue(_ element: T) {
        stackOne.push(element)
    }
    
    public func dequeue() -> T? {
        if isEmpty() { return nil }
        if stackTwo.isEmpty() { moveStackOneToStackTwo() }
        return stackTwo.pop()
    }
    
    public func peek() -> T? {
        if isEmpty() { return nil }
        if stackTwo.isEmpty() { moveStackOneToStackTwo() }
        return stackTwo.peek()
    }
    
    public func isEmpty() -> Bool {
        return stackOne.isEmpty() && stackTwo.isEmpty()
    }
    
    public func size() -> Int {
        return stackOne.size() + stackTwo.size()
    }
    
    private func moveStackOneToStackTwo() {
        while let element = stackOne.pop() {
            stackTwo.push(element)
        }
    }
    
}
