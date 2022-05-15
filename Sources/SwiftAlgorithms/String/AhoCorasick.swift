//
//  AhoCorasick.swift
//  Created by hg on 14/05/2022.
//

import Foundation

public class AhoCorasick {
    
    private var trie: Trie!
    
    public init(patterns: [String]) {
        self.trie = Trie()
        buildTrie(patterns: patterns)
    }
    
    // O(n) where n is the sum of the length of the patterns.
    private func buildTrie(patterns: [String]) {
        patterns.forEach { trie.insert($0) }
        
        let queue = TwoStackQueue<(Trie.Node,Trie.Node)>()
        for next in trie.root.next.values { queue.enqueue((trie.root, next)) }
        
        while let (prev, current) = queue.dequeue() {
            if prev === trie.root {
                current.suffixLink = trie.root
            }
            else {
                var node = prev.suffixLink!
                
                while current.suffixLink == nil {
                    if let someNode = node.next[current.value] {
                        current.suffixLink = someNode
                    }
                    else if node === trie.root {
                        current.suffixLink = trie.root
                    }
                    else {
                        node = node.suffixLink!
                    }
                }
                
                if current.suffixLink!.isMember {
                    current.outputLink = current.suffixLink
                }
                else {
                    current.outputLink = current.suffixLink!.outputLink
                }
            }
            
            for next in current.next.values { queue.enqueue((current, next)) }
        }
    }
    
    // O(m + z) where m is the length of the string and z the number of matches.
    public func matches(in string: String) -> [Range<String.Index>] {
        var node = trie.root
        var matches = [Range<String.Index>]()
        var index = string.startIndex
        
        while index < string.endIndex {
            let char = string[index]
            
            if let someNode = node.next[char] {
                node = someNode
                index = string.index(after: index)
            }
            else if let suffixLink = node.suffixLink {
                node = suffixLink
            }
            else {
                index = string.index(after: index)
            }
            
            if node.isMember || node.outputLink != nil {
                let source = node.isMember ? node : node.outputLink!
                let ranges = getRanges(from: source, to: index, in: string)
                matches.append(contentsOf: ranges)
            }
        }
        
        return matches
    }
    
    private func getRanges(from node: Trie.Node, to end: String.Index, in word: String) -> [Range<String.Index>] {
        var node: Trie.Node? = node
        var ranges = [Range<String.Index>]()
        
        while let someNode = node {
            let lowerBound = word.index(end, offsetBy: -someNode.level)
            ranges.append(lowerBound..<end)
            node = someNode.outputLink
        }
        
        return ranges
    }
    
}

extension AhoCorasick {
    
    fileprivate class Trie {
        let root = Node(value: "\0")
        
        func insert(_ newMember: String) {
            var node = root
            var level = 1
            
            for char in newMember {
                if let someNode = node.next[char] {
                    node = someNode
                }
                else {
                    let newNode = Node(value: char, level: level)
                    node.next[char] = newNode
                    node = newNode
                }
                
                level += 1
            }
            
            node.isMember = true
        }
    }
    
}

extension AhoCorasick.Trie {
    
    fileprivate class Node {
        var value: Character
        var next: [Character: Node]
        var isMember: Bool
        var suffixLink: Node?
        var outputLink: Node?
        var level: Int
        
        fileprivate init(value: Character, isMember: Bool = false, level: Int = 0) {
            self.value = value
            self.next = [Character: Node]()
            self.isMember = isMember
            self.level = level
        }
    }
    
}
