//
//  Deque.swift
//  Created by hg on 12/07/2022.
//

import Foundation

public struct Deque<T> {
    
    fileprivate let capacity: Int
    fileprivate var ring: [T?]
    fileprivate var start: Int
    fileprivate var end: Int
    var count: Int
    
    public init(capacity: Int) {
        self.capacity = capacity
        self.ring = [T?](repeating: nil, count: capacity)
        self.start = 0
        self.end = 0
        self.count = 0
    }
    
    public var isEmpty: Bool { count == 0 }
    
    public var first: T? {
        guard !isEmpty else { return nil }
        return ring[start]
    }
    
    public var last: T? {
        guard !isEmpty else { return nil }
        let lastIndex = end == 0 ? capacity - 1 : end - 1
        return ring[lastIndex]
    }
    
    public mutating func append(_ element: T) {
        guard count < capacity else { return }
        ring[end] = element
        end = (end + 1) % capacity
        count += 1
    }
    
    public mutating func prepend(_ element: T) {
        guard count < capacity else { return }
        start -= 1
        if start < 0 { start = capacity - 1 }
        ring[start] = element
        count += 1
    }
    
    @discardableResult
    public mutating func popFirst() -> T? {
        guard !isEmpty else { return nil }
        let first = ring[start]
        count -= 1
        start += 1
        if start == capacity { start = 0 }
        return first
    }
    
    @discardableResult
    public mutating func popLast() -> T? {
        guard !isEmpty else { return nil }
        count -= 1
        end -= 1
        if end < 0 { end = capacity  - 1 }
        return ring[end]
    }
    
}

extension Deque: Sequence {
    
    public typealias Iterator = DequeIterator
    public typealias Element = T
    
    public func makeIterator() -> DequeIterator<T> {
        return DequeIterator(self)
    }
    
}

public struct DequeIterator<T>: IteratorProtocol {
    
    let deque: Deque<T>
    var index: Int
    var count: Int
    
    public init(_ deque: Deque<T>) {
        self.deque = deque
        self.index = deque.start
        self.count = 0
    }
    
    public mutating func next() -> T? {
        guard count < deque.count else { return nil }
        let next = deque.ring[index]
        index = (index + 1) % deque.capacity
        count += 1
        return next
    }
    
}
