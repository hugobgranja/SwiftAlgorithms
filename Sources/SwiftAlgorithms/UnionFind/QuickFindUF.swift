//
//  QuickFindUF.swift
//  Created by hg on 26/09/2020.
//

import Foundation

public class QuickFindUF: UnionFind {
    
    public enum Exception: Error {
        case invalidArgument
        case argumentOutOfRange
    }
    
    private var id: [Int]
    private var count: Int
    
    public required init(length: Int) throws {
        if length <= 0 { throw Exception.invalidArgument }
        id = [Int](0..<length)
        count = length
    }
    
    public func union(_ p: Int, _ q: Int) throws {
        try validate(p)
        try validate(q)
        
        let pid = id[p]
        let qid = id[q]
        
        if pid == qid { return }
        
        for i in id {
            if id[i] == pid { id[i] = qid }
        }
        
        count -= 1
    }
    
    public func connected(_ p: Int, _ q: Int) throws -> Bool {
        try validate(p)
        try validate(q)
        return id[p] == id[q]
    }
    
    public func find(_ p: Int) throws -> Int {
        try validate(p)
        return id[p]
    }
    
    public func components() -> Int {
        return count
    }
    
    private func validate(_ p: Int) throws {
        if p < 0 || p >= id.count {
            throw Exception.argumentOutOfRange
        }
    }
    
}
