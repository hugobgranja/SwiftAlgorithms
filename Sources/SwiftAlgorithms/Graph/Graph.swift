//
//  Graph.swift
//  Created by hg on 07/03/2022.
//

import Foundation

public protocol Graph {
    
    func addEdge(v: Int, w: Int)
    func adjacent(to vertex: Int) -> [Int]
    func vertexCount() -> Int
    func edgeCount() -> Int
    
}
