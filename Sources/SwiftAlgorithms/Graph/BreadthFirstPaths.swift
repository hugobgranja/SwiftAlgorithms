//
//  BreadthFirstPaths.swift
//  Created by hg on 27/03/2021.
//
//  Finds shortest paths from a source vertex to every other vertex.
//  O(V + E) time worst case.
//  O(V) space.
//

import Foundation

public class BreadthFirstPaths {
    
    private var marked: [Bool]
    private var edgeTo: [Int?]
    private var distTo: [Int?]
    private var source: Int
    
    public init(graph: Graph, source: Int) {
        let count = graph.vertexCount()
        self.marked = [Bool](repeating: false, count: count)
        self.edgeTo = [Int?](repeating: nil, count: count)
        self.distTo = [Int?](repeating: nil, count: count)
        self.source = source
        
        bfs(graph: graph, source: source)
    }
    
    private func bfs(graph: Graph, source: Int) {
        let queue = LinkedListQueue<Int>()
        queue.enqueue(source)
        distTo[source] = 0
        marked[source] = true
        
        while let vertex = queue.dequeue() {
            for adjacentVertex in graph.adjacent(to: vertex) {
                if !marked[adjacentVertex] {
                    queue.enqueue(adjacentVertex)
                    marked[adjacentVertex] = true
                    edgeTo[adjacentVertex] = vertex
                    distTo[adjacentVertex] = distTo[vertex]! + 1
                }
            }
        }
    }
    
    public func hasPath(to vertex: Int) -> Bool {
        return marked[vertex]
    }
    
    public func distance(to vertex: Int) -> Int? {
        return distTo[vertex]
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
