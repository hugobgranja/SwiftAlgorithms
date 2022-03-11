//
//  Digraph.swift
//  Created by hg on 07/03/2022.
//

import Foundation

public class Digraph: Graph {
    
    private var edges: Int
    private var adjacencyLists: [[Int]]
    private var indegree: [Int]
    
    public init(vertices: Int) {
        self.edges = 0
        self.adjacencyLists = [[Int]](repeating: [], count: vertices)
        self.indegree = [Int](repeating: 0, count: vertices)
    }
    
    public func addEdge(v: Int, w: Int) {
        adjacencyLists[v].append(w)
        edges += 1
        indegree[w] += 1
    }
    
    public func adjacent(to vertex: Int) -> [Int] {
        return adjacencyLists[vertex]
    }
    
    public func vertexCount() -> Int {
        return adjacencyLists.count
    }
    
    public func edgeCount() -> Int {
        return edges
    }
    
    public func outdegree(of vertex: Int) -> Int {
        return adjacencyLists[vertex].count
    }
    
    public func indegree(of vertex: Int) -> Int {
        return indegree[vertex]
    }
    
    public func reversed() -> Digraph {
        let reversed = Digraph(vertices: vertexCount())
        
        for v in 0..<vertexCount() {
            for w in adjacent(to: v) {
                reversed.addEdge(v: w, w: v)
            }
        }
        
        return reversed
    }
    
}
