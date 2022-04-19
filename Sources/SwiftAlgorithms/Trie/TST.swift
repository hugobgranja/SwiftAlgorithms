//
//  TST.swift
//  Created by hg on 19/04/2022.
//

import Foundation

public class TST<Value> {
    
    private var root: Node?
    public var count: Int
    
    public init() {
        self.count = 0
    }
    
    public func insert<T: StringProtocol>(key: T, value: Value?) {
        if !contains(key: key) { count += 1 }
        else if value == nil { count -= 1 }
        root = insert(from: root, key: key, value: value, at: 0)
    }
    
    private func insert<T: StringProtocol>(from node: Node?, key: T, value: Value?, at index: Int) -> Node {
        let char = key[index]
        let node = node ?? Node(char: char)
        
        if char < node.char {
            node.left = insert(from: node.left, key: key, value: value, at: index)
        }
        else if char > node.char {
            node.right = insert(from: node.right, key: key, value: value, at: index)
        }
        else if index < key.count - 1 {
            node.mid = insert(from: node.mid, key: key, value: value, at: index + 1)
        }
        else {
            node.value = value
        }
        
        return node
    }
    
    public func contains<T: StringProtocol>(key: T) -> Bool {
        return get(key: key) != nil
    }
    
    public func get<T: StringProtocol>(key: T) -> Value? {
        if key.isEmpty { return nil }
        let node = get(from: root, key: key, at: 0)
        return node?.value
    }
    
    private func get<T: StringProtocol>(from node: Node?, key: T, at index: Int) -> Node? {
        guard let someNode = node else { return nil }
        let char = key[index]
        if char < someNode.char { return get(from: someNode.left, key: key, at: index) }
        else if char > someNode.char { return get(from: someNode.right, key: key, at: index) }
        else if index < key.count - 1 { return get(from: someNode.mid, key: key, at: index + 1) }
        else { return node }
    }
    
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    public func longestPrefix<T: StringProtocol>(of query: T) -> T.SubSequence? {
        if query.isEmpty { return nil }
        var length = 0
        var node = root
        var index = 0
        
        while let someNode = node, index < query.count {
            let char = query[index]
            
            if char < someNode.char { node = someNode.left }
            else if char > someNode.char { node = someNode.right }
            else {
                index += 1
                if someNode.value != nil { length = index }
                node = someNode.mid
            }
        }
        
        return query.subsequence(from: 0, length: length)
    }
    
    public func keys() -> [String] {
        var keys = [String]()
        collect(from: root, prefix: "", keys: &keys)
        return keys
    }
    
    private func collect<T: StringProtocol>(from node: Node?, prefix: T, keys: inout [String]) {
        guard let someNode = node else { return }
        collect(from: someNode.left, prefix: prefix, keys: &keys)
        if someNode.value != nil { keys.append("\(prefix)\(someNode.char)") }
        collect(from: someNode.mid, prefix: "\(prefix)\(someNode.char)", keys: &keys)
        collect(from: someNode.right, prefix: prefix, keys: &keys)
    }
    
    public func prefixed<T: StringProtocol>(by prefix: T) -> [String] {
        if prefix.isEmpty { return [] }
        let node = get(from: root, key: prefix, at: 0)
        guard let someNode = node else { return [] }
        var keys = [String]()
        if someNode.value != nil { keys.append(String(prefix)) }
        collect(from: someNode.mid, prefix: prefix, keys: &keys)
        return keys
    }
    
}

extension TST {
    
    public class Node {
        
        public let char: Character
        public var left: Node?
        public var mid: Node?
        public var right: Node?
        public var value: Value?
        
        fileprivate init(
            char: Character,
            left: Node? = nil,
            mid: Node? = nil,
            right: Node? = nil,
            value: Value? = nil
        ) {
            self.char = char
            self.left = left
            self.mid = mid
            self.right = right
            self.value = value
        }
        
    }
    
}
