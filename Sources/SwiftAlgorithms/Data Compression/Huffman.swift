//
//  Huffman.swift
//  Created by hg on 18/04/2022.
//

import Foundation

public class Huffman {
    
    private let radix: Int
    
    public init() {
        self.radix = 128
    }
    
    public func compress(_ string: String) -> Data? {
        let frequencyCounts = createFrequencyCounts(string: string)
        guard let root = createTrie(frequencyCounts: frequencyCounts) else { return nil }
        let codeTable = createCodeTable(node: root)
        let builder = encodeTrie(node: root)
        builder.append(Int64(string.count))
        
        for char in string {
            let asciiValue = Int(char.asciiValue!)
            let code = codeTable[asciiValue]
            
            for char in code {
                if char == "0" { builder.append(bit: false) }
                else { builder.append(bit: true) }
            }
        }
        
        return builder.getData()
    }
    
    private func createFrequencyCounts(string: String) -> [Int] {
        var frequencyCounts = [Int](repeating: 0, count: radix)
        
        for char in string {
            let asciiValue = Int(char.asciiValue!)
            frequencyCounts[asciiValue] += 1
        }
        
        return frequencyCounts
    }
    
    private func createTrie(frequencyCounts: [Int]) -> Node? {
        let pq = MinBinaryHeap<Node>()
        
        for index in 0..<frequencyCounts.count {
            let frequency = frequencyCounts[index]
            
            if frequency > 0 {
                let char = UnicodeScalar(index).map { Character($0) }!
                let newNode = Node(char: char, frequency: frequency)
                pq.enqueue(newNode)
            }
        }
        
        while pq.size() > 1 {
            let left = pq.dequeue()
            let right = pq.dequeue()
            let frequency = (left?.frequency ?? 0) + (right?.frequency ?? 0)
            let parent = Node(char: "\0", frequency: frequency, left: left, right: right)
            pq.enqueue(parent)
        }
        
        return pq.dequeue()
    }
    
    private func createCodeTable(node: Node) -> [String] {
        var codeTable = [String](repeating: "", count: radix)
        let stack = ArrayStack<(Node, String)>([(node, "")])
        
        while let (node, code) = stack.pop() {
            if node.isLeaf() {
                let asciiValue = Int(node.char.asciiValue!)
                codeTable[asciiValue] = code
            }
            else {
                if let left = node.left { stack.push((left, code + "0")) }
                if let right = node.right { stack.push((right, code + "1")) }
            }
        }
        
        return codeTable
    }
    
    private func encodeTrie(node: Node) -> BinaryDataBuilder {
        let builder = BinaryDataBuilder()
        let stack = ArrayStack<Node>([node])
        
        while let node = stack.pop() {
            if node.isLeaf() {
                builder.append(bit: true)
                builder.append(byte: node.char.asciiValue!)
            }
            else {
                builder.append(bit: false)
                if let right = node.right { stack.push(right) }
                if let left = node.left { stack.push(left) }
            }
        }
        
        return builder
    }
    
    public func expand(data: Data) -> String? {
        let reader = BinaryDataReader(data: data)
        
        guard
            let root = readTrie(reader: reader),
            let length = reader.readInt64()
        else {
            return nil
        }
        
        var string = ""
        
        for _ in 0..<length {
            var node = root
            
            while !node.isLeaf() {
                let bit = reader.readBit()!
                if bit { node = node.right! }
                else { node = node.left! }
            }
            
            string.append(node.char)
        }
        
        return string
    }
    
    private func readTrie(reader: BinaryDataReader) -> Node? {
        guard let isLeaf = reader.readBit() else { return nil }
        
        if isLeaf {
            let asciiValue = reader.readByte()!
            let char = Character(UnicodeScalar(asciiValue))
            return Node(char: char, frequency: -1)
        }
        else {
            return Node(
                char: "\0",
                frequency: -1,
                left: readTrie(reader: reader),
                right: readTrie(reader: reader)
            )
        }
    }
    
}

extension Huffman {
    
    fileprivate class Node: Comparable {
        
        let char: Character
        let frequency: Int
        let left: Node?
        let right: Node?
        
        init(char: Character, frequency: Int, left: Node? = nil, right: Node? = nil) {
            self.char = char
            self.frequency = frequency
            self.left = left
            self.right = right
        }
        
        func isLeaf() -> Bool {
            return left == nil && right == nil
        }
        
        static func == (lhs: Huffman.Node, rhs: Huffman.Node) -> Bool {
            return lhs.char == rhs.char
        }
        
        static func < (lhs: Huffman.Node, rhs: Huffman.Node) -> Bool {
            return lhs.frequency < rhs.frequency
        }
        
    }
    
}
