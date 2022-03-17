//
//  QuickUnionUF.swift
//  Created by hg on 26/09/2020.
//

import Foundation

public class QuickUnionUF: UnionFind {
    
    private var parent: [Int]
    private var count: Int
    
    public required init(length: Int) {
        parent = [Int](0..<length)
        count = length
    }
    
    public func union(_ p: Int, _ q: Int) {
        let i = find(p)
        let j = find(q)
        if i == j { return }
        parent[i] = j
        count -= 1
    }
    
    public func connected(_ p: Int, _ q: Int) -> Bool {
        let i = find(p)
        let j = find(q)
        return i == j
    }
    
    public func find(_ p: Int) -> Int {
        var i = p
        while i != parent[i] { i = parent[i] }
        return i
    }
    
    public func components() -> Int {
        return count
    }
    
}
