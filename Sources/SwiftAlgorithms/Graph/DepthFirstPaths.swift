//
//  DepthFirstPaths.swift
//  Created by hg on 25/03/2021.
//
//  Finds paths from a source vertex to every other vertex.
//  O(V + E) time worst case.
//  O(V) space.
//

import Foundation

public class DepthFirstPaths {
    
    private var marked: [Bool]
    private var edgeTo: [Int?]
    private var source: Int
    
    public init(graph: Graph, source: Int) {
        let count = graph.vertexCount()
        self.marked = [Bool](repeating: false, count: count)
        self.edgeTo = [Int?](repeating: nil, count: count)
        self.source = source
        
        dfs(graph: graph, source: source)
    }
    
    private func dfs(graph: Graph, source: Int) {
        marked[source] = true
        
        for vertex in graph.adjacent(to: source) {
            if !marked[vertex] {
                dfs(graph: graph, source: vertex)
                edgeTo[vertex] = source
            }
        }
    }
    
    private func dfsIterative(graph: Graph, source: Int) {
        var stack = ArrayStack<Int>([source])
        
        while let vertex = stack.pop() {
            marked[vertex] = true
            
            for adjacentVertex in graph.adjacent(to: vertex) {
                if !marked[adjacentVertex] {
                    stack.push(adjacentVertex)
                    edgeTo[adjacentVertex] = vertex
                }
            }
        }
    }
    
    public func hasPath(to vertex: Int) -> Bool {
        return marked[vertex]
    }
    
    public func path(to vertex: Int) -> [Int]? {
        guard hasPath(to: vertex) else { return nil }
        
        var path = [Int]()
        var w = vertex
        
        while w != source {
            path.append(w)
            w = edgeTo[w]!
        }
        
        path.append(source)
        
        return path.reversed()
    }
    
}
