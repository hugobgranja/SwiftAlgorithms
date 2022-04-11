//
//  TrieSet.swift
//  Created by hg on 04/04/2022.
//

import Foundation

public class TrieSet {
    
    private let radix: Int
    private var root: Node
    public var count: Int
    
    public init() {
        self.radix = 128
        self.root = Node(radix: radix, isMember: false)
        self.count = 0
    }
    
    public func insert(_ newMember: String) {
        var node = root
        var index = 0
        
        while index < newMember.count {
            if let someNode = get(from: node, to: newMember, at: index) {
                node = someNode
            }
            else {
                let value = newMember.asciiValue(at: index)!
                let newNode = Node(radix: radix, isMember: false)
                node.next[value] = newNode
                node = newNode
            }
            
            index += 1
        }
        
        if !node.isMember { count += 1 }
        node.isMember = true
    }
    
    public func contains(_ member: String) -> Bool {
        let node = get(from: root, to: member)
        return node?.isMember == true
    }
    
    private func get<T: StringProtocol>(from node: Node, to member: T) -> Node? {
        var node = root
        var index = 0
        
        while let someNode = get(from: node, to: member, at: index), index < member.count {
            node = someNode
            index += 1
        }
        
        return index == member.count ? node : nil
    }
    
    private func get<T: StringProtocol>(from node: Node, to member: T, at index: Int) -> Node? {
        guard index < member.count else { return nil }
        return member.asciiValue(at: index).flatMap { node.next[$0] }
    }
    
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    public func prefixed(by member: String) -> [String] {
        guard let prefixNode = get(from: root, to: member) else { return [] }
        return collect(node: prefixNode, prefix: member)
    }
    
    private func collect(node: Node, prefix: String) -> [String] {
        var collected = [String]()
        
        let stack = ArrayStack<(Node, String)>()
        stack.push((node, ""))
        
        while let (node, suffix) = stack.pop() {
            if node.isMember { collected.append(prefix + suffix) }
            
            for value in 0..<radix {
                if
                    let nextNode = node.next[value],
                    let char = asciiChar(of: value)
                {
                    let newSuffix = suffix + char
                    stack.push((nextNode, newSuffix))
                }
            }
        }
        
        return collected
    }
    
    public func longestPrefix(of member: String) -> String? {
        var longest: Substring?
        var node = root
        var index = 0
        
        while let someNode = get(from: node, to: member, at: index), index < member.count {
            if someNode.isMember {
                longest = member.prefix(index + 1)
            }
            
            node = someNode
            index += 1
        }
        
        return longest.map { String($0) }
    }
    
    private func asciiChar(of value: Int) -> String? {
        return UnicodeScalar(value).map { String($0) }
    }
    
}

extension TrieSet {
    
    public class Node {
        
        public var next: [Node?]
        public var isMember: Bool
        
        fileprivate init(radix: Int, isMember: Bool) {
            self.next = [Node?](repeating: nil, count: radix)
            self.isMember = isMember
        }
        
    }
    
}
