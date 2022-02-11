//
//  TreeNode.swift
//  Created by hg on 31/12/2020.
//

import Foundation

public class TreeNode<Key, Value> where Key: Comparable {
    
    public var key: Key
    public var value: Value
    public var left: TreeNode<Key,Value>?
    public var right: TreeNode<Key,Value>?
    public var count: Int
    
    public init(key: Key, value: Value) {
        self.key = key
        self.value = value
        self.count = 1
    }
    
}
