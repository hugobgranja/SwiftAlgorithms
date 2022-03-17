//
//  QuickFindUF.swift
//  Created by hg on 26/09/2020.
//

import Foundation

public class QuickFindUF: UnionFind {
    
    private var id: [Int]
    private var count: Int
    
    public required init(length: Int) {
        id = [Int](0..<length)
        count = length
    }
    
    public func union(_ p: Int, _ q: Int) {
        let pid = id[p]
        let qid = id[q]
        
        if pid == qid { return }
        
        for i in id {
            if id[i] == pid { id[i] = qid }
        }
        
        count -= 1
    }
    
    public func connected(_ p: Int, _ q: Int) -> Bool {
        return id[p] == id[q]
    }
    
    public func find(_ p: Int) -> Int {
        return id[p]
    }
    
    public func components() -> Int {
        return count
    }
    
}
