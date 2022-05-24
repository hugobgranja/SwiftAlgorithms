//
//  BSTNode.swift
//  Created by hg on 31/12/2020.
//

import Foundation

public class BSTNode<Key, Value> where Key: Comparable {
    
    public var key: Key
    public var value: Value
    public var left: BSTNode<Key,Value>?
    public var right: BSTNode<Key,Value>?
    public var count: Int
    
    public init(key: Key, value: Value) {
        self.key = key
        self.value = value
        self.count = 1
    }
    
}
