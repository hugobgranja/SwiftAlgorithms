//
//  BinaryTree.swift
//  Created by hg on 31/12/2020.
//

import Foundation

public protocol BinaryTree {
    
    associatedtype Key
    associatedtype Value
    
    func put(key: Key, value: Value)
    func get(key: Key) -> Value?
    func delete(key: Key)
    func isEmpty() -> Bool
    func size() -> Int
    
}
