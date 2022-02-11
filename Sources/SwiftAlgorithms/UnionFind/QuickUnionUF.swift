//
//  QuickUnionUF.swift
//  Created by hg on 26/09/2020.
//

import Foundation

public class QuickUnionUF: UnionFind {

    public enum Exception: Error {
        case invalidArgument
        case argumentOutOfRange
    }
    
    private var parent: [Int]
    private var count: Int
    
    public required init(length: Int) throws {
        if length <= 0 { throw Exception.invalidArgument }
        parent = [Int](0..<length)
        count = length
    }
    
    public func union(_ p: Int, _ q: Int) throws {
        let i = try find(p)
        let j = try find(q)
        if i == j { return }
        parent[i] = j
        count -= 1
    }
    
    public func connected(_ p: Int, _ q: Int) throws -> Bool {
        let i = try find(p)
        let j = try find(q)
        return i == j
    }
    
    public func find(_ p: Int) throws -> Int {
        try validate(p)
        var i = p
        while i != parent[i] { i = parent[i] }
        return i
    }
    
    public func components() -> Int {
        return count
    }
    
    private func validate(_ p: Int) throws {
        if p < 0 || p >= parent.count {
            throw Exception.argumentOutOfRange
        }
    }
    
}
