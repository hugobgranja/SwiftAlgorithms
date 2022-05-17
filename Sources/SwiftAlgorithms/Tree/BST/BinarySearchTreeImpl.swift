//
//  BinarySearchTreeImpl.swift
//  Created by hg on 31/12/2020.
//

import Foundation

public class BinarySearchTreeImpl<Key, Value>: BinarySearchTree where Key: Comparable {
    
    public var root: TreeNode<Key,Value>?
    
    public init() {}
    
    public func put(key: Key, value: Value) {
        root = put(key: key, value: value, node: root)
    }
    
    private func put(key: Key, value: Value, node: TreeNode<Key,Value>?) -> TreeNode<Key,Value> {
        guard let someNode = node else { return TreeNode<Key,Value>(key: key, value: value) }
        
        if key < someNode.key { someNode.left = put(key: key, value: value, node: someNode.left) }
        else if key > someNode.key { someNode.right = put(key: key, value: value, node: someNode.right) }
        else { someNode.value = value }
        someNode.count = 1 + size(node: someNode.left) + size(node: someNode.right)
        return someNode
    }
    
    public func get(key: Key) -> Value? {
        var node = root
        
        while let someNode = node {
            if key < someNode.key { node = someNode.left }
            else if key > someNode.key { node = someNode.right }
            else { return someNode.value }
        }
        
        return nil
    }
    
    public func contains(key: Key) -> Bool {
        return get(key: key) != nil
    }
    
    public func max() -> KeyValuePair? {
        guard let root = root else { return nil }
        let maxNode = max(node: root)
        return (maxNode.key, maxNode.value)
    }
    
    private func max(node: TreeNode<Key,Value>) -> TreeNode<Key,Value> {
        var node = node
        while let someNode = node.right { node = someNode }
        return node
    }
    
    public func min() -> KeyValuePair? {
        guard let root = root else { return nil }
        let minNode = min(node: root)
        return (minNode.key, minNode.value)
    }
    
    private func min(node: TreeNode<Key,Value>) -> TreeNode<Key,Value> {
        var node = node
        while let someNode = node.left { node = someNode }
        return node
    }
    
    public func floor(key: Key) -> KeyValuePair? {
        guard let node = floor(key: key, node: root) else { return nil }
        return (node.key, node.value)
    }
    
    private func floor(key: Key, node: TreeNode<Key,Value>?) -> TreeNode<Key,Value>? {
        guard let someNode = node else { return nil }
        
        if key == someNode.key { return someNode }
        if key < someNode.key { return floor(key: key, node: someNode.left) }
        
        let rightFloorNode = floor(key: key, node: someNode.right)
        if let rightFloorNode = rightFloorNode { return rightFloorNode }
        else { return someNode }
    }
    
    public func ceiling(key: Key) -> KeyValuePair? {
        guard let node = ceiling(key: key, node: root) else { return nil }
        return (node.key, node.value)
    }
    
    private func ceiling(key: Key, node: TreeNode<Key,Value>?) -> TreeNode<Key,Value>? {
        guard let someNode = node else { return nil }
        
        if key == someNode.key { return someNode }
        if key > someNode.key { return ceiling(key: key, node: someNode.right) }
        
        let leftFloorNode = ceiling(key: key, node: someNode.left)
        if let leftFloorNode = leftFloorNode { return leftFloorNode }
        else { return someNode }
    }
    
    public func select(rank: Int) -> KeyValuePair? {
        guard
            rank >= 0 && rank < size(),
            let node = select(rank: rank, node: root)
        else {
            return nil
        }
        
        return (node.key, node.value)
    }
    
    private func select(rank: Int, node: TreeNode<Key,Value>?) -> TreeNode<Key,Value>? {
        guard let someNode = node else { return nil }
        
        let leftSize = size(node: someNode.left)
        if leftSize > rank { return select(rank: rank, node: someNode.left) }
        if leftSize < rank { return select(rank: rank - leftSize - 1, node: someNode.right) }
        else { return someNode }
    }
    
    public func rank(key: Key) -> Int {
        return rank(key: key, node: root)
    }
    
    private func rank(key: Key, node: TreeNode<Key,Value>?) -> Int {
        guard let someNode = node else { return 0 }
        if key < someNode.key { return rank(key: key, node: someNode.left) }
        else if key > someNode.key { return 1 + size(node: someNode.left) + rank(key: key, node: someNode.right) }
        else { return size(node: someNode.left) }
    }
    
    public func deleteMin() {
        root = deleteMin(node: root)
    }
    
    private func deleteMin(node: TreeNode<Key,Value>?) -> TreeNode<Key,Value>? {
        guard let someNode = node else { return nil }
        if someNode.left == nil { return someNode.right }
        someNode.left = deleteMin(node: someNode.left)
        someNode.count = 1 + size(node: someNode.left) + size(node: someNode.right)
        return someNode
    }
    
    public func deleteMax() {
        root = deleteMax(node: root)
    }
    
    private func deleteMax(node: TreeNode<Key,Value>?) -> TreeNode<Key,Value>? {
        guard let someNode = node else { return nil }
        if someNode.right == nil { return someNode.left }
        someNode.right = deleteMax(node: someNode.right)
        someNode.count = 1 + size(node: someNode.left) + size(node: someNode.right)
        return someNode
    }
    
    public func delete(key: Key) {
        root = delete(key: key, node: root)
    }
    
    private func delete(key: Key, node: TreeNode<Key,Value>?) -> TreeNode<Key,Value>? {
        guard var someNode = node else { return nil }
        if key < someNode.key { someNode.left = delete(key: key, node: someNode.left) }
        else if key > someNode.key { someNode.right = delete(key: key, node: someNode.right) }
        else {
            if someNode.right == nil { return someNode.left }
            if someNode.left == nil { return someNode.right }
            
            let auxNode = someNode
            someNode = min(node: auxNode.right!)
            someNode.right = deleteMin(node: auxNode.right)
            someNode.left = auxNode.left
        }
        
        someNode.count = 1 + size(node: someNode.left) + size(node: someNode.right)
        return someNode
    }
    
    public func size() -> Int {
        return size(node: root)
    }
    
    private func size(node: TreeNode<Key, Value>?) -> Int {
        return node?.count ?? 0
    }
    
    public func isEmpty() -> Bool {
        return root == nil
    }
    
    public func keys() -> [Key] {
        var keys = [Key]()
        let it = BSTInorderIterator<Key, Value>(self)
        while let next = it.next() { keys.append(next.key) }
        return keys
    }
    
}

public class BSTInorderIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<KeyValuePair>
    
    public init(_ bst: BinarySearchTreeImpl<Key,Value>) {
        self.queue = LinkedListQueue()
        initQueue(node: bst.root)
    }
    
    private func initQueue(node: TreeNode<Key,Value>?) {
        guard let someNode = node else { return }
        initQueue(node: someNode.left)
        queue.enqueue((someNode.key, someNode.value))
        initQueue(node: someNode.right)
    }

    public func next() -> KeyValuePair? {
        return queue.dequeue()
    }
    
}

public class BSTPreorderIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<KeyValuePair>
    
    public init(_ bst: BinarySearchTreeImpl<Key,Value>) {
        self.queue = LinkedListQueue()
        initQueue(node: bst.root)
    }
    
    private func initQueue(node: TreeNode<Key,Value>?) {
        guard let someNode = node else { return }
        queue.enqueue((someNode.key, someNode.value))
        initQueue(node: someNode.left)
        initQueue(node: someNode.right)
    }

    public func next() -> KeyValuePair? {
        return queue.dequeue()
    }
    
}

public class BSTPostorderIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<KeyValuePair>
    
    public init(_ bst: BinarySearchTreeImpl<Key,Value>) {
        self.queue = LinkedListQueue()
        initQueue(node: bst.root)
    }
    
    private func initQueue(node: TreeNode<Key,Value>?) {
        guard let someNode = node else { return }
        initQueue(node: someNode.left)
        initQueue(node: someNode.right)
        queue.enqueue((someNode.key, someNode.value))
    }

    public func next() -> KeyValuePair? {
        return queue.dequeue()
    }
    
}

public struct BSTLevelIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<TreeNode<Key,Value>>
    
    public init(_ bst: BinarySearchTreeImpl<Key,Value>) {
        self.queue = LinkedListQueue()
        if let root = bst.root { queue.enqueue(root) }
    }

    public func next() -> KeyValuePair? {
        guard let node = queue.dequeue() else { return nil }
        
        if let left = node.left { queue.enqueue(left) }
        if let right = node.right { queue.enqueue(right) }
        
        return (node.key, node.value)
    }
    
}

extension BinarySearchTreeImpl where Key: CustomStringConvertible {
    
    public func printTree() {
        guard let root = root else { return }
        
        let queue = LinkedListQueue<(Key?, TreeNode<Key,Value>)>()
        queue.enqueue((nil, root))
        
        while let node = queue.dequeue() {
            if let left = node.1.left { queue.enqueue((node.1.key, left)) }
            if let right = node.1.right { queue.enqueue((node.1.key, right)) }
            print("Key: \(node.1.key) | Parent: \(String(describing: node.0))")
        }
    }
    
}
