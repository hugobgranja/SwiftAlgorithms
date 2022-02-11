//
//  Graph.swift
//  Created by hg on 23/03/2021.
//

import Foundation

public class UndirectedGraph: Graph {
    
    private var edges: Int
    private var adjacencyLists: [[Int]]
    
    public init(vertices: Int) {
        self.edges = 0
        self.adjacencyLists = [[Int]](repeating: [], count: vertices)
    }
    
    public func addEdge(v: Int, w: Int) {
        adjacencyLists[v].append(w)
        adjacencyLists[w].append(v)
        edges += 1
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
    
    public func degree(of vertex: Int) -> Int {
        return adjacencyLists[vertex].count
    }
    
}
