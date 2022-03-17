//
//  UnionFind.swift
//  Created by hg on 26/09/2020.
//

import Foundation

public protocol UnionFind {
    
    init(length: Int)
    func union(_ p: Int, _ q: Int)
    func connected(_ p: Int, _ q: Int) -> Bool
    func find(_ p: Int) -> Int
    func components() -> Int
    
}
