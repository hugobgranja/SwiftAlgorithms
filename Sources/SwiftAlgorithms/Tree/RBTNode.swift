//
//  RBTNode.swift
//  Created by hg on 03/01/2021.
//

import Foundation

public class RBTNode<Key, Value> where Key: Comparable {
    public var key: Key
    public var value: Value
    public var left: RBTNode<Key,Value>?
    public var right: RBTNode<Key,Value>?
    public var count: Int
    public var color: Color
    
    public init(key: Key, value: Value, color: Color) {
        self.key = key
        self.value = value
        self.color = color
        self.count = 1
    }
}

extension RBTNode {
    public enum Color {
        case red
        case black
    }
}
