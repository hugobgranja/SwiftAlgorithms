//
//  CLRSRBT.swift
//  Red-black BST from Introduction to Algorithms.
//  Created by hg on 13/01/2021.
//

import Foundation

public class CLRSRBT<Key, Value>: BinarySearchTree where Key: Comparable {
    
    fileprivate var root: CLRSNode<Key,Value>
    fileprivate var nilNode: CLRSNode<Key,Value>
    
    public init() {
        self.nilNode = .none(CLRSNilNode())
        self.root = nilNode
    }
    
    public func put(key: Key, value: Value) {
        if case let .some(x) = getNode(key: key) {
            x.value = value
            return
        }
        
        var x = root
        var y = nilNode
        
        while case let .some(someX) = x {
            y = x
            someX.count += 1
            if key < someX.key { x = someX.left }
            else { x = someX.right }
        }
        
        let z = CLRSNode<Key,Value>(
            key: key,
            value: value,
            color: .red,
            parent: y,
            left: nilNode,
            right: nilNode
        )
        
        if case let .some(y) = y {
            if key < y.key { y.left = z }
            else { y.right = z }
        }
        else {
            root = z
        }
        
        putFixup(node: z)
    }
    
    private func putFixup(node: CLRSNode<Key,Value>) {
        var z = node
        
        while z.parent.color == .red {
            if z.parent == z.parent.parent.left {
                var y = z.parent.parent.right
                
                if y.color == .red {
                    z.parent.color = .black
                    y.color = .black
                    z.parent.parent.color = .red
                    z = z.parent.parent
                }
                else {
                    if z == z.parent.right {
                        z = z.parent
                        rotateLeft(node: z)
                    }
                    
                    z.parent.color = .black
                    z.parent.parent.color = .red
                    rotateRight(node: z.parent.parent)
                }
            }
            else {
                var y = z.parent.parent.left
                
                if y.color == .red {
                    z.parent.color = .black
                    y.color = .black
                    z.parent.parent.color = .red
                    z = z.parent.parent
                }
                else {
                    if z == z.parent.left {
                        z = z.parent
                        rotateRight(node: z)
                    }
                    
                    z.parent.color = .black
                    z.parent.parent.color = .red
                    rotateLeft(node: z.parent.parent)
                }
            }
        }
        
        root.color = .black
    }
    
    public func get(key: Key) -> Value? {
        return getNode(key: key).value
    }
    
    private func getNode(key: Key) -> CLRSNode<Key,Value> {
        var x = root
        
        while case let .some(someX) = x {
            if key < someX.key { x = someX.left }
            else if key > someX.key { x = someX.right }
            else { return x }
        }
        
        return nilNode
    }
    
    public func contains(key: Key) -> Bool {
        return get(key: key) != nil
    }
    
    public func deleteMin() {
        delete(node: min(node: root))
    }
    
    public func deleteMax() {
        delete(node: max(node: root))
    }
    
    public func delete(key: Key) {
        let x = getNode(key: key)
        if x != nilNode { delete(node: x) }
    }
    
    private func delete(node: CLRSNode<Key,Value>) {
        var y = node
        var yOriginalColor = y.color
        var x: CLRSNode<Key,Value>
        
        if node.left == nilNode {
            maintainSizeDelete(node: node)
            x = node.right
            transplant(u: node, v: node.right)
        }
        else if node.right == nilNode {
            maintainSizeDelete(node: node)
            x = node.left
            transplant(u: node, v: node.left)
        }
        else {
            y = min(node: node.right)
            yOriginalColor = y.color
            x = y.right
            
            maintainSizeDelete(node: y)
            
            if y.parent == node { x.parent = y }
            else {
                transplant(u: y, v: y.right)
                y.right = node.right
                y.right.parent = y
            }
            
            transplant(u: node, v: y)
            y.left = node.left
            y.left.parent = y
            y.color = node.color
            y.count = node.count
        }
        
        if yOriginalColor == .black { deleteFixup(node: x) }
    }
    
    private func transplant(u: CLRSNode<Key,Value>, v: CLRSNode<Key,Value>) {
        var u = u, v = v
        if u.parent == nilNode { root = v }
        else if u == u.parent.left { u.parent.left = v }
        else { u.parent.right = v }
        v.parent = u.parent
    }
    
    private func deleteFixup(node: CLRSNode<Key,Value>) {
        var x = node
        var w: CLRSNode<Key,Value>
        
        while x != root && x.color == .black {
            if x == x.parent.left {
                w = x.parent.right
                
                if w.color == .red {
                    w.color = .black
                    x.parent.color = .red
                    rotateLeft(node: x.parent)
                    w = x.parent.right
                }
                
                if w.left.color == .black && w.right.color == .black {
                    w.color = .red
                    x = x.parent
                }
                else {
                    if w.right.color == .black {
                        w.left.color = .black
                        w.color = .red
                        rotateRight(node: w)
                        w = x.parent.right
                    }
                    
                    w.color = x.parent.color
                    x.parent.color = .black
                    w.right.color = .black
                    rotateLeft(node: x.parent)
                    x = root
                }
            }
            else {
                w = x.parent.left
                
                if w.color == .red {
                    w.color = .black
                    x.parent.color = .red
                    rotateRight(node: x.parent)
                    w = x.parent.left
                }
                
                if w.left.color == .black && w.right.color == .black {
                    w.color = .red
                    x = x.parent
                }
                else {
                    if w.left.color == .black {
                        w.right.color = .black
                        w.color = .red
                        rotateLeft(node: w)
                        w = x.parent.left
                    }
                    
                    w.color = x.parent.color
                    x.parent.color = .black
                    w.left.color = .black
                    rotateRight(node: x.parent)
                    x = root
                }
            }
        }
        
        x.color = .black
    }
    
    private func maintainSizeDelete(node: CLRSNode<Key,Value>) {
        var x = node
        
        while x.parent != nilNode {
            x.parent.count -= 1
            x = x.parent
        }
    }
    
    public func isEmpty() -> Bool {
        return root == nilNode
    }
    
    private func rotateLeft(node: CLRSNode<Key,Value>) {
        var x = node
        var y = node.right
        x.right = y.left
        
        if y.left != nilNode { y.left.parent = x }
        y.parent = x.parent
        
        if node.parent == nilNode { root = y }
        else if x == x.parent.left { x.parent.left = y }
        else { x.parent.right = y }
        
        y.left = node
        x.parent = y
        y.count = x.count
        x.count = 1 + x.left.count + x.right.count
    }
    
    private func rotateRight(node: CLRSNode<Key,Value>) {
        var x = node
        var y = node.left
        x.left = y.right
        
        if y.right != nilNode { y.right.parent = x }
        y.parent = x.parent
        
        if node.parent == nilNode { root = y }
        else if x == x.parent.right { x.parent.right = y }
        else { x.parent.left = y }
        
        y.right = node
        x.parent = y
        y.count = x.count
        x.count = 1 + x.left.count + x.right.count
    }
    
    public func size() -> Int {
        return root.count
    }
    
    public func max() -> KeyValuePair? {
        guard case let .some(node) = max(node: root) else { return nil }
        return (node.key, node.value)
    }
    
    private func max(node: CLRSNode<Key,Value>) -> CLRSNode<Key,Value> {
        var x = node
        while x.right != nilNode { x = x.right }
        return x
    }
    
    public func min() -> KeyValuePair? {
        guard case let .some(node) = min(node: root) else { return nil }
        return (node.key, node.value)
    }
    
    private func min(node: CLRSNode<Key,Value>) -> CLRSNode<Key,Value> {
        var x = node
        while x.left != nilNode { x = x.left }
        return x
    }
    
    public func floor(key: Key) -> KeyValuePair? {
        guard case let .some(node) = floor(key: key, node: root) else { return nil }
        return (node.key, node.value)
    }
    
    private func floor(key: Key, node: CLRSNode<Key,Value>) -> CLRSNode<Key,Value> {
        guard case let .some(x) = node else { return nilNode }
        
        if key == x.key { return node }
        if key < x.key { return floor(key: key, node: x.left) }
        
        let rightFloor = floor(key: key, node: x.right)
        if rightFloor == nilNode { return node }
        else { return rightFloor }
    }
    
    public func ceiling(key: Key) -> KeyValuePair? {
        guard case let .some(node) = ceiling(key: key, node: root) else { return nil }
        return (node.key, node.value)
    }
    
    private func ceiling(key: Key, node: CLRSNode<Key,Value>) -> CLRSNode<Key,Value> {
        guard case let .some(x) = node else { return nilNode }
        
        if key == x.key { return node }
        if key > x.key { return ceiling(key: key, node: x.right) }
        
        let leftFloor = ceiling(key: key, node: x.left)
        if leftFloor == nilNode { return node }
        else { return leftFloor }
    }

    public func select(rank: Int) -> KeyValuePair? {
        guard
            rank >= 0 && rank < size(),
            let node = select(rank: rank, node: root),
            case let .some(someNode) = node
        else {
            return nil
        }
        
        return (someNode.key, someNode.value)
    }
    
    private func select(rank: Int, node: CLRSNode<Key,Value>) -> CLRSNode<Key,Value>? {
        let leftSize = node.left.count
        if leftSize > rank { return select(rank: rank, node: node.left) }
        if leftSize < rank { return select(rank: rank - leftSize - 1, node: node.right) }
        else { return node }
    }
    
    public func rank(key: Key) -> Int {
        return rank(key: key, node: root)
    }
    
    private func rank(key: Key, node: CLRSNode<Key,Value>) -> Int {
        guard case let .some(someNode) = node else { return 0 }
        if key < someNode.key { return rank(key: key, node: someNode.left) }
        else if key > someNode.key { return 1 + someNode.left.count + rank(key: key, node: someNode.right) }
        else { return someNode.left.count }
    }
    
    public func size(low: Key, high: Key) -> Int {
        let size = rank(key: high) - rank(key: low)
        return contains(key: high) ? size + 1 : size
    }
    
    public func rangeSearch(low: Key, high: Key) -> [KeyValuePair] {
        return rangeSearch(low: low, high: high, node: root)
        
    }
    
    private func rangeSearch(low: Key, high: Key, node: CLRSNode<Key,Value>) -> [KeyValuePair] {
        guard case let .some(node) = node else { return [] }
        
        var range = [KeyValuePair]()
        
        if node.key > low {
            let leftRange = rangeSearch(low: low, high: high, node: node.left)
            range.append(contentsOf: leftRange)
        }
        
        if node.key >= low && node.key <= high {
            range.append((node.key, node.value))
        }
        
        if node.key < high {
            let rightRange = rangeSearch(low: low, high: high, node: node.right)
            range.append(contentsOf: rightRange)
        }
        
        return range
    }
    
    public func keys() -> [Key] {
        var keys = [Key]()
        let it = CLRSRBTInorderIterator<Key, Value>(self)
        while let next = it.next() { keys.append(next.key) }
        return keys
    }
    
    public func isBST() -> Bool {
        guard root != nilNode else { return true }
        let isLeftBST = isBST(node: root.left, minKey: nil, maxKey: root.key)
        let isRightBST = isBST(node: root.right, minKey: root.key, maxKey: nil)
        return isLeftBST && isRightBST
    }
    
    private func isBST(node: CLRSNode<Key,Value>, minKey: Key?, maxKey: Key?) -> Bool {
        guard case let .some(someNode) = node else { return true }
        if let minKey = minKey, someNode.key < minKey { return false }
        if let maxKey = maxKey, someNode.key > maxKey { return false }
        let isLeftBST = isBST(node: node.left, minKey: minKey, maxKey: someNode.key)
        let isRightBST = isBST(node: node.right, minKey: someNode.key, maxKey: maxKey)
        return isLeftBST && isRightBST
    }
    
    public func isSizeConsistent() -> Bool {
        return isSizeConsistent(node: root)
    }
    
    private func isSizeConsistent(node: CLRSNode<Key,Value>) -> Bool {
        guard node != nilNode else { return true }
        if node.count != 1 + node.left.count +  node.right.count { return false }
        return isSizeConsistent(node: node.left) && isSizeConsistent(node: node.right)
    }
    
    // Checks if the tree has at most one red link in a row on any path
    public func isColorConsistent() -> Bool {
        if root.color == .red { return false }
        return isColorConsistent(node: root)
    }
    
    private func isColorConsistent(node: CLRSNode<Key,Value>) -> Bool {
        guard node != nilNode else { return true }
        if node.color == .red && (node.left.color == .red || node.right.color == .red) { return false }
        return isColorConsistent(node: node.left) && isColorConsistent(node: node.right)
    }
    
    // Check if all paths from root to leaf have the same number of black nodes
    public func isBalanced() -> Bool {
        guard root != nilNode else { return true }
        var pathsBlackCount = [Int]()
        countPaths(node: root, blackCount: 0, pathsBlackCount: &pathsBlackCount)
        return pathsBlackCount.allSatisfy { $0 == pathsBlackCount.first }
    }
    
    private func countPaths(node: CLRSNode<Key,Value>, blackCount: Int, pathsBlackCount: inout [Int]) {
        var blackCount = blackCount
        if node.color == .black { blackCount += 1 }
        
        if node.left == nilNode && node.right == nilNode {
            pathsBlackCount.append(blackCount)
        }
        else {
            if node.left != nilNode {
                countPaths(node: node.left, blackCount: blackCount, pathsBlackCount: &pathsBlackCount)
            }
            if node.right != nilNode {
                countPaths(node: node.right, blackCount: blackCount, pathsBlackCount: &pathsBlackCount)
            }
        }
    }
    
}

public class CLRSRBTInorderIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<KeyValuePair>
    
    public init(_ bst: CLRSRBT<Key,Value>) {
        self.queue = LinkedListQueue()
        initQueue(node: bst.root)
    }
    
    private func initQueue(node: CLRSNode<Key,Value>) {
        guard case let .some(someNode) = node else { return }
        initQueue(node: someNode.left)
        queue.enqueue((someNode.key, someNode.value))
        initQueue(node: someNode.right)
    }

    public func next() -> KeyValuePair? {
        return queue.dequeue()
    }
    
}

public class CLRSRBTPreorderIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<KeyValuePair>
    
    public init(_ bst: CLRSRBT<Key,Value>) {
        self.queue = LinkedListQueue()
        initQueue(node: bst.root)
    }
    
    private func initQueue(node: CLRSNode<Key,Value>) {
        guard case let .some(someNode) = node else { return }
        queue.enqueue((someNode.key, someNode.value))
        initQueue(node: someNode.left)
        initQueue(node: someNode.right)
    }

    public func next() -> KeyValuePair? {
        return queue.dequeue()
    }
    
}

public class CLRSRBTPostorderIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<KeyValuePair>
    
    public init(_ bst: CLRSRBT<Key,Value>) {
        self.queue = LinkedListQueue()
        initQueue(node: bst.root)
    }
    
    private func initQueue(node: CLRSNode<Key,Value>) {
        guard case let .some(someNode) = node else { return }
        initQueue(node: someNode.left)
        initQueue(node: someNode.right)
        queue.enqueue((someNode.key, someNode.value))
    }

    public func next() -> KeyValuePair? {
        return queue.dequeue()
    }
    
}

public struct CLRSRBTLevelIterator<Key,Value>: IteratorProtocol where Key: Comparable {
    
    public typealias KeyValuePair = (key: Key, value: Value)
    
    private let queue: LinkedListQueue<CLRSNode<Key,Value>>
    
    public init(_ bst: CLRSRBT<Key,Value>) {
        self.queue = LinkedListQueue()
        if bst.root != bst.nilNode { queue.enqueue(bst.root) }
    }

    public func next() -> KeyValuePair? {
        guard case let .some(.some(node)) = queue.dequeue() else { return nil }
        if case .some = node.left { queue.enqueue(node.left) }
        if case .some = node.right { queue.enqueue(node.right) }
        return (node.key, node.value)
    }
    
}

extension CLRSRBT where Key: CustomStringConvertible {
    
    public func printTree() {
        guard root != nilNode else { return }
        
        let queue = LinkedListQueue<CLRSNode<Key,Value>>()
        queue.enqueue(root)
        
        while let node = queue.dequeue() {
            if case .some = node.left { queue.enqueue(node.left) }
            if case .some = node.right { queue.enqueue(node.right) }
            print("Key: \(String(describing: node.key)) | Parent: \(String(describing: node.parent.key)) | Color: \(node.color) | Count: \(node.count)")
        }
    }
    
}
