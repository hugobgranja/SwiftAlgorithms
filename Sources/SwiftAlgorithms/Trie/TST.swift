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
        root = insert(from: root, key: key, value: value, at: key.startIndex)
    }
    
    private func insert<T: StringProtocol>(from node: Node?, key: T, value: Value?, at index: T.Index) -> Node {
        let char = key[index]
        let node = node ?? Node(char: char)
        
        if char < node.char {
            node.left = insert(from: node.left, key: key, value: value, at: index)
        }
        else if char > node.char {
            node.right = insert(from: node.right, key: key, value: value, at: index)
        }
        else if index < key.index(before: key.endIndex) {
            let nextIndex = key.index(after: index)
            node.mid = insert(from: node.mid, key: key, value: value, at: nextIndex)
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
        let node = get(from: root, key: key, at: key.startIndex)
        return node?.value
    }
    
    private func get<T: StringProtocol>(from node: Node?, key: T, at index: T.Index) -> Node? {
        guard let someNode = node else { return nil }
        let char = key[index]
        
        if char < someNode.char {
            return get(from: someNode.left, key: key, at: index)
        }
        else if char > someNode.char {
            return get(from: someNode.right, key: key, at: index)
        }
        else if index < key.index(before: key.endIndex) {
            return get(from: someNode.mid, key: key, at: key.index(after: index))
        }
        else {
            return node
        }
    }
    
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    public func longestPrefix<T: StringProtocol>(of query: T) -> T.SubSequence? {
        if query.isEmpty { return nil }
        var node = root
        var index = query.startIndex
        var endIndex: T.Index?
        
        while let someNode = node, index < query.endIndex {
            let char = query[index]
            
            if char < someNode.char { node = someNode.left }
            else if char > someNode.char { node = someNode.right }
            else {
                index = query.index(after: index)
                if someNode.value != nil { endIndex = index }
                node = someNode.mid
            }
        }
        
        return endIndex.map { query.prefix(upTo: $0) } ?? ""
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
        let node = get(from: root, key: prefix, at: prefix.startIndex)
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
