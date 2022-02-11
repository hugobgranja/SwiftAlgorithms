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
    public var color: RBTNodeColor
    
    public init(key: Key, value: Value, color: RBTNodeColor) {
        self.key = key
        self.value = value
        self.color = color
        self.count = 1
    }
    
    public func flipColor() {
        switch color {
        case .red: color = .black
        case .black: color = .red
        }
    }
    
}

extension RBTNode: Equatable {
    
    public static func == (lhs: RBTNode<Key, Value>, rhs: RBTNode<Key, Value>) -> Bool {
        return lhs.key == rhs.key
    }
    
}
