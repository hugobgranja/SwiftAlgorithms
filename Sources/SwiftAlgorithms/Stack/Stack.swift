//
//  Stack.swift
//  Created by hg on 11/10/2020.
//

import Foundation

public protocol Stack {
    
    associatedtype T
    
    func push(_ element: T)
    func pop() -> T?
    func peek() -> T?
    func isEmpty() -> Bool
    func size() -> Int
    
}
