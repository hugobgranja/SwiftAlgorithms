//
//  IndexedPriorityQueue.swift
//  Created by hg on 14/03/2022.
//

import Foundation

public class IndexedPriorityQueue<T> {
    
    private let isLowerPriority: (T, T) -> Bool
    private var pq: [Int]
    private var qp: [Int]
    private var keys: [T?]
    private var count: Int
    
    public init(length: Int, isLowerPriority: @escaping (T,T) -> Bool) {
        self.isLowerPriority = isLowerPriority
        self.pq = [Int](repeating: -1, count: length)
        self.qp = [Int](repeating: -1, count: length)
        self.keys = [T?](repeating: nil, count: length)
        self.count = 0
    }
    
    public func enqueue(index: Int, key: T) {
        guard !contains(index: index) else { return }
        qp[index] = count
        pq[count] = index
        keys[index] = key
        swim(count)
        count += 1
    }
    
    public func dequeue() -> (Int, T)? {
        guard size() > 0 else { return nil }
        
        let index = pq[0]
        let key = keys[pq[0]]!
        swap(0, size() - 1)
        count -= 1
        sink(0)
        qp[index] = -1
        keys[index] = nil
        pq[count] = -1
        
        return (index, key)
    }
    
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    public func contains(index: Int) -> Bool {
        return qp[index] != -1
    }
    
    public func size() -> Int {
        return count
    }
    
    public func peekIndex() -> Int? {
        guard !isEmpty() else { return nil }
        return pq[0]
    }
    
    public func peekKey() -> T? {
        guard !isEmpty() else { return nil }
        return keys[pq[0]]
    }
    
    public func key(of index: Int) -> T? {
        return keys[index]
    }
    
    public func changeKey(index: Int, key: T) {
        keys[index] = key
        swim(qp[index])
        sink(qp[index])
    }
    
    public func decreaseKey(index: Int, key: T) {
        guard let someKey = keys[index], isLowerPriority(someKey, key) else { return }
        keys[index] = key
        swim(qp[index])
    }
    
    public func increaseKey(index: Int, key: T) {
        guard let someKey = keys[index], !isLowerPriority(someKey, key) else { return }
        keys[index] = key
        sink(qp[index])
    }
    
    public func delete(index: Int) {
        guard contains(index: index) else { return }
        let j = qp[index]
        swap(j, count - 1)
        count -= 1
        swim(j)
        sink(j)
        keys[index] = nil
        qp[index] = -1
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
    
    private func isLowerPriority(i: Int, j: Int) -> Bool {
        let iKey = keys[pq[i]]!
        let jKey = keys[pq[j]]!
        return isLowerPriority(iKey, jKey)
    }
    
    private func swap(_ i: Int, _ j: Int) {
        pq.swapAt(i, j)
        qp[pq[i]] = i
        qp[pq[j]] = j
    }
    
    private func swim(_ k: Int) {
        var k = k
        var kparent = parent(k)
        
        while k > 0 && isLowerPriority(i: kparent, j: k) {
            swap(k, kparent)
            k = kparent
            kparent = parent(k)
        }
    }
    
    private func sink(_ k: Int) {
        let end = size()
        var k = k, leftIndex = left(k)
        
        while leftIndex < end {
            let rightIndex = right(k)
            var swapIndex = leftIndex
            
            if rightIndex < end && isLowerPriority(i: leftIndex, j: rightIndex) { swapIndex = rightIndex }
            if isLowerPriority(i: swapIndex, j: k) { break }
            swap(k, swapIndex)
            
            k = swapIndex
            leftIndex = left(k)
        }
    }
    
}
