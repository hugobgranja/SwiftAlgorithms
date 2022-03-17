//
//  WeightedWeightedQuickUnionUF.swift
//  Created by hg on 26/09/2020.
//

import Foundation

public class WeightedQuickUnionUF: UnionFind {
    
    private var parent: [Int]
    private var size: [Int]
    private var count: Int
    
    public required init(length: Int) {
        parent = [Int]()
        size = [Int]()
        
        for i in 0..<length {
            parent.append(i)
            size.append(1)
        }
        
        count = length
    }
    
    public func union(_ p: Int, _ q: Int) {
        let i = find(p)
        let j = find(q)
        
        if i == j { return }
        
        if size[i] < size[j] {
            parent[i] = j
            size[j] += size[i]
        }
        else  {
            parent[j] = i
            size[i] += size[j]
        }
        
        count -= 1
    }
    
    public func connected(_ p: Int, _ q: Int) -> Bool {
        let i = find(p)
        let j = find(q)
        return i == j
    }
    
    public func find(_ p: Int) -> Int {
        var i = p
        while i != parent[i] {
            // Path compression by halving
            parent[i] = parent[parent[i]]
            i = parent[i]
        }
        
        return i
    }
    
    public func components() -> Int {
        return count
    }
    
}
