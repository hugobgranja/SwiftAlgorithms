//
//  UnionFind.swift
//  Created by hg on 26/09/2020.
//

import Foundation

public protocol UnionFind {
    
    init(length: Int) throws
    func union(_ p: Int, _ q: Int) throws
    func connected(_ p: Int, _ q: Int) throws -> Bool
    func find(_ p: Int) throws -> Int
    func components() -> Int
    
}
