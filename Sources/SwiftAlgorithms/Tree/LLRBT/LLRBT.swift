//
//  LLRBT.swift
//  Left-leaning Red-black BST.
//  Created by hg on 03/01/2021.
//

import Foundation

public class LLRBT<Key, Value>: BinarySearchTree where Key: Comparable {
    
    public var root: RBTNode<Key,Value>?
    
    public init() {}
    
    public func put(key: Key, value: Value) {
        root = put(key: key, value: value, node: root)
        root?.color = .black
    }
    
    private func put(key: Key, value: Value, node: RBTNode<Key,Value>?) -> RBTNode<Key,Value> {
        guard let someNode = node else { return RBTNode<Key,Value>(key: key, value: value, color: .red) }
        
        if key < someNode.key { someNode.left = put(key: key, value: value, node: someNode.left) }
        else if key > someNode.key { someNode.right = put(key: key, value: value, node: someNode.right) }
        else { someNode.value = value }
        
        return balance(node: someNode)
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
    
    public func deleteMin() {
        guard let someRoot = root else { return }
        
        if !isRed(node: someRoot.left) && !isRed(node: someRoot.right) {
            someRoot.color = .red
        }
        
        root = deleteMin(node: someRoot)
        
        if let root = root { root.color = .black }
    }
    
    private func deleteMin(node: RBTNode<Key,Value>?) -> RBTNode<Key,Value>? {
        guard var someNode = node, someNode.left != nil else { return nil }
        
        if !isRed(node: someNode.left) && !isRed(node: someNode.left?.left) {
            someNode = moveRedLeft(node: someNode)
        }
        
        someNode.left = deleteMin(node: someNode.left)
        return balance(node: someNode)
    }
    
    public func deleteMax() {
        guard let someRoot = root else { return }
        
        if !isRed(node: someRoot.left) && !isRed(node: someRoot.right) {
            someRoot.color = .red
        }
        
        root = deleteMax(node: someRoot)
        
        if let root = root { root.color = .black }
    }
    
    private func deleteMax(node: RBTNode<Key,Value>?) -> RBTNode<Key,Value>? {
        guard var someNode = node else { return nil }
        
        if isRed(node: someNode.left) { someNode = rotateRight(node: someNode) }
        if someNode.right == nil { return nil }
        
        if !isRed(node: someNode.right) && !isRed(node: someNode.right?.left) {
            someNode = moveRedRight(node: someNode)
        }
        
        someNode.right = deleteMax(node: someNode.right)
        return balance(node: someNode)
    }
    
    public func delete(key: Key) {
        guard let someRoot = root, contains(key: key) else { return }
        if !isRed(node: someRoot.left) && !isRed(node: someRoot.right) { someRoot.color = .red }
        root = delete(key: key, node: someRoot)
        if let root = root { root.color = .black }
    }
    
    private func delete(key: Key, node: RBTNode<Key,Value>?) -> RBTNode<Key,Value>? {
        guard var someNode = node else { return nil }
        
        if key < someNode.key {
            if !isRed(node: someNode.left) && !isRed(node: someNode.left?.left) {
                someNode = moveRedLeft(node: someNode)
            }
            
            someNode.left = delete(key: key, node: someNode.left)
        }
        else {
            if isRed(node: someNode.left) { someNode = rotateRight(node: someNode) }
            if key == someNode.key && someNode.right == nil { return nil }
            if !isRed(node: someNode.right) && !isRed(node: someNode.right?.left) { someNode = moveRedRight(node: someNode) }
            if key == someNode.key {
                let minNode = min(node: someNode.right!)
                someNode.key = minNode.key
                someNode.value = minNode.value
                someNode.right = deleteMin(node: someNode.right)
            }
            else {
                someNode.right = delete(key: key, node: someNode.right)
            }
        }
        
        return balance(node: someNode)
    }
    
    public func isEmpty() -> Bool {
        return root == nil
    }
    
    private func balance(node: RBTNode<Key,Value>) -> RBTNode<Key,Value> {
        var node = node
        
        if isRed(node: node.right) && !isRed(node: node.left) { node = rotateLeft(node: node) }
        if isRed(node: node.left) && isRed(node: node.left?.left) { node = rotateRight(node: node) }
        if isRed(node: node.left) && isRed(node: node.right) { flipColors(node: node) }
        node.count = 1 + size(node: node.left) + size(node: node.right)
        
        return node
    }
    
    private func rotateLeft(node: RBTNode<Key,Value>) -> RBTNode<Key,Value> {
        guard let rightNode = node.right else { return node }
        node.right = rightNode.left
        rightNode.left = node
        rightNode.color = node.color
        node.color = .red
        rightNode.count = node.count
        node.count = 1 + size(node: node.left) + size(node: node.right)
        return rightNode
    }
    
    private func rotateRight(node: RBTNode<Key,Value>) -> RBTNode<Key,Value> {
        guard let leftNode = node.left else { return node }
        node.left = leftNode.right
        leftNode.right = node
        leftNode.color = node.color
        node.color = .red
        leftNode.count = node.count
        node.count = 1 + size(node: node.left) + size(node: node.right)
        return leftNode
    }
    
    private func flipColors(node: RBTNode<Key,Value>) {
        node.flipColor()
        node.left?.flipColor()
        node.right?.flipColor()
    }
    
    private func moveRedLeft(node: RBTNode<Key,Value>) -> RBTNode<Key,Value> {
        var node = node
        
        flipColors(node: node)
        
        if let rightNode = node.right, isRed(node: rightNode.left) {
            node.right = rotateRight(node: rightNode)
            node = rotateLeft(node: node)
            flipColors(node: node)
        }
        
        return node
    }
    
    private func moveRedRight(node: RBTNode<Key,Value>) -> RBTNode<Key,Value> {
        var node = node
        
        flipColors(node: node)
        
        if isRed(node: node.left?.left) {
            node = rotateRight(node: node)
            flipColors(node: node)
        }
        
        return node
    }
    
    private func isRed(node: RBTNode<Key,Value>?) -> Bool {
        return node?.color == .red
    }
    
    public func size() -> Int {
        return size(node: root)
    }
    
    private func size(node: RBTNode<Key, Value>?) -> Int {
        return node?.count ?? 0
    }
    
    public func max() -> KeyValuePair? {
        guard let root = root else { return nil }
        let maxNode = max(node: root)
        return (maxNode.key, maxNode.value)
    }
    
    private func max(node: RBTNode<Key,Value>) -> RBTNode<Key,Value> {
        var node = node
        while let someNode = node.right { node = someNode }
        return node
    }
    
    public func min() -> KeyValuePair? {
        guard let root = root else { return nil }
        let minNode = min(node: root)
        return (minNode.key, minNode.value)
    }
    
    private func min(node: RBTNode<Key,Value>) -> RBTNode<Key,Value> {
        var node = node
        while let someNode = node.left { node = someNode }
        return node
    }
    
    public func floor(key: Key) -> KeyValuePair? {
        guard let node = floor(key: key, node: root) else { return nil }
        return (node.key, node.value)
    }
    
    private func floor(key: Key, node: RBTNode<Key,Value>?) -> RBTNode<Key,Value>? {
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
    
    private func ceiling(key: Key, node: RBTNode<Key,Value>?) -> RBTNode<Key,Value>? {
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
    
    private func select(rank: Int, node: RBTNode<Key,Value>?) -> RBTNode<Key,Value>? {
        guard let someNode = node else { return nil }
        
        let leftSize = size(node: someNode.left)
        if leftSize > rank { return select(rank: rank, node: someNode.left) }
        if leftSize < rank { return select(rank: rank - leftSize - 1, node: someNode.right) }
        else { return someNode }
    }
    
    public func rank(key: Key) -> Int {
        return rank(key: key, node: root)
    }
    
    private func rank(key: Key, node: RBTNode<Key,Value>?) -> Int {
        guard let someNode = node else { return 0 }
        if key < someNode.key { return rank(key: key, node: someNode.left) }
        else if key > someNode.key { return 1 + size(node: someNode.left) + rank(key: key, node: someNode.right) }
        else { return size(node: someNode.left) }
    }
    
    public func size(low: Key, high: Key) -> Int {
        let size = rank(key: high) - rank(key: low)
        return contains(key: high) ? size + 1 : size
    }
    
    public func rangeSearch(low: Key, high: Key) -> [KeyValuePair] {
        guard let root = root else { return [] }
        return rangeSearch(low: low, high: high, node: root)
        
    }
    
    private func rangeSearch(low: Key, high: Key, node: RBTNode<Key,Value>) -> [KeyValuePair] {
        var range = [KeyValuePair]()
        
        if node.key > low, let left = node.left {
            let leftRange = rangeSearch(low: low, high: high, node: left)
            range.append(contentsOf: leftRange)
        }
        
        if node.key >= low && node.key <= high {
            range.append((node.key, node.value))
        }
        
        if node.key < high, let right = node.right {
            let rightRange = rangeSearch(low: low, high: high, node: right)
            range.append(contentsOf: rightRange)
        }
        
        return range
    }
    
    public func keys() -> [Key] {
        var keys = [Key]()
        let it = LLRBTInorderIterator<Key, Value>(self)
        while let next = it.next() { keys.append(next.key) }
        return keys
    }
    
    public func isBST() -> Bool {
        guard let root = root else { return true }
        let isLeftBST = isBST(node: root.left, minKey: nil, maxKey: root.key)
        let isRightBST = isBST(node: root.right, minKey: root.key, maxKey: nil)
        return isLeftBST && isRightBST
    }
    
    private func isBST(node: RBTNode<Key,Value>?, minKey: Key?, maxKey: Key?) -> Bool {
        guard let someNode = node else { return true }
        if let minKey = minKey, someNode.key < minKey { return false }
        if let maxKey = maxKey, someNode.key > maxKey { return false }
        let isLeftBST = isBST(node: node?.left, minKey: minKey, maxKey: someNode.key)
        let isRightBST = isBST(node: node?.right, minKey: someNode.key, maxKey: maxKey)
        return isLeftBST && isRightBST
    }
    
    public func isSizeConsistent() -> Bool {
        return isSizeConsistent(node: root)
    }
    
    private func isSizeConsistent(node: RBTNode<Key,Value>?) -> Bool {
        guard let someNode = node else { return true }
        if someNode.count != 1 + size(node: someNode.left) + size(node: someNode.right) { return false }
        return isSizeConsistent(node: someNode.left) && isSizeConsistent(node: someNode.right)
    }
    
    // Checks if the tree has no red right links and
    // at most one left red link in a row on any path
    public func is23() -> Bool {
        return is23(node: root)
    }
    
    private func is23(node: RBTNode<Key,Value>?) -> Bool {
        guard let someNode = node else { return true }
        if isRed(node: someNode.right) { return false }
        if someNode != root && isRed(node: someNode) && isRed(node: someNode.left) { return false }
        return is23(node: someNode.left) && is23(node: someNode.right)
    }
    
    // Check if all paths from root to leaf have the same number of black edges
    public func isBalanced() -> Bool {
        var blackCount = 0
        var node = root
        
        while let someNode = node {
            if !isRed(node: someNode) { blackCount += 1 }
            node = someNode.left
        }
        
        return isBalanced(node: root, blackCount: blackCount)
    }
    
    private func isBalanced(node: RBTNode<Key,Value>?, blackCount: Int) -> Bool {
        guard let someNode = node else { return blackCount == 0 }
        var blackCount = blackCount
        if !isRed(node: someNode) { blackCount -= 1 }
        let isBalancedLeft = isBalanced(node: someNode.left, blackCount: blackCount)
        let isBalancedRight = isBalanced(node: someNode.right, blackCount: blackCount)
        return isBalancedLeft && isBalancedRight
    }
    
}

public class LLRBTInorderIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<KeyValuePair>
    
    public init(_ bst: LLRBT<Key,Value>) {
        self.queue = LinkedListQueue()
        initQueue(node: bst.root)
    }
    
    private func initQueue(node: RBTNode<Key,Value>?) {
        guard let someNode = node else { return }
        initQueue(node: someNode.left)
        queue.enqueue((someNode.key, someNode.value))
        initQueue(node: someNode.right)
    }

    public func next() -> KeyValuePair? {
        return queue.dequeue()
    }
    
}

public class LLRBTPreorderIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<KeyValuePair>
    
    public init(_ bst: LLRBT<Key,Value>) {
        self.queue = LinkedListQueue()
        initQueue(node: bst.root)
    }
    
    private func initQueue(node: RBTNode<Key,Value>?) {
        guard let someNode = node else { return }
        queue.enqueue((someNode.key, someNode.value))
        initQueue(node: someNode.left)
        initQueue(node: someNode.right)
    }

    public func next() -> KeyValuePair? {
        return queue.dequeue()
    }
    
}

public class LLRBTPostorderIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<KeyValuePair>
    
    public init(_ bst: LLRBT<Key,Value>) {
        self.queue = LinkedListQueue()
        initQueue(node: bst.root)
    }
    
    private func initQueue(node: RBTNode<Key,Value>?) {
        guard let someNode = node else { return }
        initQueue(node: someNode.left)
        initQueue(node: someNode.right)
        queue.enqueue((someNode.key, someNode.value))
    }

    public func next() -> KeyValuePair? {
        return queue.dequeue()
    }
    
}

public struct LLRBTLevelIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<RBTNode<Key,Value>>
    
    public init(_ bst: LLRBT<Key,Value>) {
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


extension LLRBT where Key: CustomStringConvertible {
    
    public func printTree() {
        guard let root = root else { return }
        
        let queue = LinkedListQueue<(Key?, RBTNode<Key,Value>)>()
        queue.enqueue((nil, root))
        
        while let node = queue.dequeue() {
            if let left = node.1.left { queue.enqueue((node.1.key, left)) }
            if let right = node.1.right { queue.enqueue((node.1.key, right)) }
            print("Key: \(node.1.key) | Parent: \(String(describing: node.0)) | Color: \(node.1.color)")
        }
    }
    
}
