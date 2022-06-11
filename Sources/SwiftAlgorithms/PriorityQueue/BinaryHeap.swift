//
//  BinaryHeap.swift
//  Created by hg on 22/12/2020.
//

import Foundation

public class BinaryHeap<T>: PriorityQueue {
    
    private var heap: [T]
    private let isLowerPriority: (T, T) -> Bool
    
    public init(isLowerPriority: @escaping (T,T) -> Bool) {
        self.heap = [T]()
        self.isLowerPriority = isLowerPriority
    }
    
    public var count: Int { heap.count }
    
    public func enqueue(_ element: T) {
        heap.append(element)
        swim(heap.count - 1)
    }
    
    public func dequeue() -> T? {
        guard count > 0 else { return nil }
        
        let root = heap[0]
        heap.swapAt(0, count - 1)
        heap.removeLast()
        sink(0)
        
        return root
    }
    
    public func peek() -> T? {
        return heap.first
    }
    
    public func isEmpty() -> Bool {
        return heap.isEmpty
    }
    
    private func parent(_ index: Int) -> Int {
        return (index - 1) / 2
    }
    
    private func left(_ index: Int) -> Int {
        return 2 * index + 1
    }
    
    private func right(_ index: Int) -> Int {
        return 2 * index + 2
    }
    
    private func swim(_ k: Int) {
        var k = k
        var kparent = parent(k)
        
        while k > 0 && isLowerPriority(heap[kparent], heap[k]) {
            heap.swapAt(k, kparent)
            k = kparent
            kparent = parent(k)
        }
    }
    
    private func sink(_ k: Int) {
        var k = k, leftIndex = left(k)
        
        while leftIndex < count {
            let rightIndex = right(k)
            var swapIndex = leftIndex
            
            if rightIndex < count && isLowerPriority(heap[leftIndex], heap[rightIndex]) { swapIndex = rightIndex }
            if isLowerPriority(heap[swapIndex], heap[k]) { break }
            heap.swapAt(k, swapIndex)
            
            k = swapIndex
            leftIndex = left(k)
        }
    }
    
}

extension BinaryHeap: CustomStringConvertible {
    
    public var description: String {
        return "\(heap)"
    }
    
}
