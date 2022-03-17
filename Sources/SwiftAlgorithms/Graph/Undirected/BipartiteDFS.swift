//
//  BipartiteDFS.swift
//  Created by hg on 16/05/2021.
//
//  A bipartite graph is a graph whose vertices can be divided into two disjoint and independent sets U and V where every edge connects a vertex in U to one in V.
//  A graph is bipartite if and only if it does not contain an odd cycle.
//
//  O(V + E) time worst case.
//  O(V) space.
//


import Foundation

public class BipartiteDFS {
    
    public var isBipartite: Bool
    private var color: [Bool]
    private var marked: [Bool]
    private var edgeTo: [Int?]
    private var cycle: [Int]
    
    public init(graph: Graph) {
        let count = graph.vertexCount()
        isBipartite = true
        color = [Bool](repeating: false, count: count)
        marked = [Bool](repeating: false, count: count)
        edgeTo = [Int?](repeating: nil, count: count)
        cycle = [Int]()
        
        for vertex in 0..<count {
            guard !hasCycle() else { return }
            if !marked[vertex] { dfs(graph: graph, source: vertex) }
        }
    }
    
    private func dfs(graph: Graph, source: Int) {
        marked[source] = true
        
        for vertex in graph.adjacent(to: source) {
            guard !hasCycle() else { return }
            
            if !marked[vertex] {
                edgeTo[vertex] = source
                color[vertex] = !color[source]
                dfs(graph: graph, source: vertex)
            }
            else if color[vertex] == color[source] {
                isBipartite = false
                
                cycle.append(source)
                if let path = path(from: source, to: vertex) { cycle += path }
            }
        }
    }
    
    private func path(from source: Int, to destination: Int) -> [Int]? {
        guard hasPath(to: destination) else { return nil }
        
        var path = [Int]()
        var w = source
        
        while w != destination {
            path.append(w)
            w = edgeTo[w]!
        }
        
        path.append(destination)
        
        return path.reversed()
    }
    
    private func hasPath(to vertex: Int) -> Bool {
        return marked[vertex]
    }
    
    public func color(vertex: Int) -> Bool {
        return color[vertex]
    }
    
    public func getOddCycle() -> [Int] {
        return cycle
    }
    
    private func hasCycle() -> Bool {
        return !cycle.isEmpty
    }
    
}
