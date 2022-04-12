//
//  DepthFirstSearch.swift
//  Created by hg on 12/04/2022.
//

import Foundation

public class DepthFirstSearch {
    
    private var marked: [Bool]
    var reachableCount: Int
    
    public init(graph: Graph, source: Int) {
        self.marked = [Bool](repeating: false, count: graph.vertexCount())
        self.reachableCount = 0
        dfs(graph: graph, source: source)
    }
    
    public init(graph: Graph, sources: [Int]) {
        self.marked = [Bool](repeating: false, count: graph.vertexCount())
        self.reachableCount = 0
        
        for source in sources where !marked[source] {
            dfs(graph: graph, source: source)
        }
    }
    
    private func dfs(graph: Graph, source: Int) {
        marked[source] = true
        reachableCount += 1
        
        for vertex in graph.adjacent(to: source) where !marked[vertex] {
            dfs(graph: graph, source: vertex)
        }
    }
    
    public func hasPath(to vertex: Int) -> Bool {
        return marked[vertex]
    }
    
}
