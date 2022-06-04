//
//  Graph.swift
//  Created by hg on 23/03/2021.
//

import Foundation

public class UndirectedGraph: Graph {
    
    private var edges: Int
    private var adjacencyList: [[Int]]
    
    public init(vertices: Int) {
        self.edges = 0
        self.adjacencyList = [[Int]](repeating: [], count: vertices)
    }
    
    public func addEdge(v: Int, w: Int) {
        adjacencyList[v].append(w)
        adjacencyList[w].append(v)
        edges += 1
    }
    
    public func adjacent(to vertex: Int) -> [Int] {
        return adjacencyList[vertex]
    }
    
    public func vertexCount() -> Int {
        return adjacencyList.count
    }
    
    public func edgeCount() -> Int {
        return edges
    }
    
    public func degree(of vertex: Int) -> Int {
        return adjacencyList[vertex].count
    }
    
}
