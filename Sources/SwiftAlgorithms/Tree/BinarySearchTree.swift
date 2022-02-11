//
//  BinarySearchTree.swift
//  Created by hg on 11/01/2021.
//

import Foundation

public protocol BinarySearchTree: BinaryTree {
    
    associatedtype Key
    associatedtype Value
    typealias KeyValuePair = (key: Key, value: Value)
    
    func put(key: Key, value: Value)
    func get(key: Key) -> Value?
    func contains(key: Key) -> Bool
    func max() -> KeyValuePair?
    func min() -> KeyValuePair?
    func floor(key: Key) -> KeyValuePair?
    func ceiling(key: Key) -> KeyValuePair?
    func select(rank: Int) -> KeyValuePair?
    func rank(key: Key) -> Int
    func delete(key: Key)
    func deleteMin()
    func deleteMax()
    func size() -> Int
    func isEmpty() -> Bool
    func keys() -> [Key]
    
}
