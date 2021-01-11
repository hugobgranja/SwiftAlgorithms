//
//  BinarySearchTree.swift
//  Created by hg on 11/01/2021.
//

import Foundation

protocol BinarySearchTree: BinaryTree {
    associatedtype Key
    associatedtype Value
    
    func max() -> Key?
    func min() -> Key?
    func floor(key: Key) -> Key?
    func ceiling(key: Key) -> Key?
    func select(rank: Int) -> Key?
    func rank(key: Key) -> Int
    func deleteMin()
}
