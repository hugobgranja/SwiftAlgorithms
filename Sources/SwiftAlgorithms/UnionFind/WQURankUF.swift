//
//  WQURankUF.swift
//  Created by hg on 05/05/2022.
//

import Foundation

public class WQURankUF: UnionFind {
    
    private var parent: [Int]
    private var rank: [UInt8]
    private var count: Int
    
    public required init(length: Int) {
        parent = [Int]()
        rank = [UInt8]()
        
        for i in 0..<length {
            parent.append(i)
            rank.append(0)
        }
        
        count = length
    }
    
    public func union(_ p: Int, _ q: Int) {
        let i = find(p)
        let j = find(q)
        
        if i == j { return }
        
        if rank[i] < rank[j] {
            parent[i] = j
        }
        else if rank[i] > rank[j] {
            parent[j] = parent[i]
        }
        else {
            parent[j] = i
            rank[i] += 1
        }
        
        count -= 1
    }
    
    public func connected(_ p: Int, _ q: Int) -> Bool {
        return find(p) == find(q)
    }
    
    public func find(_ p: Int) -> Int {
        var i = p
        
        while i != parent[i] {
            parent[i] = parent[parent[i]] // Path compression by halving
            i = parent[i]
        }
        
        return i
    }
    
    public func components() -> Int {
        return count
    }
    
}
