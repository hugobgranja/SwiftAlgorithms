//
//  ConnectedComponents.swift
//  Created by hg on 27/03/2021.
//
//  Determines the connected components in a graph.
//  O(V + E) time.
//  O(V) space.
//

import Foundation

public class ConnectedComponents {
    
    private var marked: [Bool]
    private var id: [Int]
    private var size: [Int]
    private var componentsCount: Int
    
    public init(graph: Graph) {
        let vertexCount = graph.vertexCount()
        marked = [Bool](repeating: false, count: vertexCount)
        id = [Int](repeating: -1, count: vertexCount)
        size = [Int](repeating: 0, count: vertexCount)
        componentsCount = 0
        findConnectedComponents(graph: graph)
    }
    
    private func findConnectedComponents(graph: Graph) {
        for v in 0..<graph.vertexCount() {
            if !marked[v] {
                dfs(graph: graph, source: v)
                componentsCount += 1
            }
        }
    }
    
    private func dfs(graph: Graph, source: Int) {
        marked[source] = true
        id[source] = componentsCount
        size[componentsCount] += 1
        
        for vertex in graph.adjacent(to: source) {
            if !marked[vertex] { dfs(graph: graph, source: vertex) }
        }
    }
    
    public func isConnected(v: Int, w: Int) -> Bool {
        return id(vertex: v) == id(vertex: w)
    }
    
    public func id(vertex: Int) -> Int {
        return id[vertex]
    }
    
    public func count() -> Int {
        return componentsCount
    }
    
    public func size(vertex: Int) -> Int {
        return size[id[vertex]]
    }
    
}
