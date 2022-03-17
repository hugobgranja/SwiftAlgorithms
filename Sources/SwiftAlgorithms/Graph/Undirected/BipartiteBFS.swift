//
//  BipartiteBFS.swift
//  Created by hg on 24/05/2021.
//
//  A bipartite graph is a graph whose vertices can be divided into two disjoint and independent sets U and V where every edge connects a vertex in U to one in V.
//  A graph is bipartite if and only if it does not contain an odd cycle.
//
//  O(V + E) time worst case.
//  O(V) space.
//

import Foundation

public class BipartiteBFS {
    
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
            guard isBipartite else { return }
            if !marked[vertex] { bfs(graph: graph, source: vertex) }
        }
    }
    
    private func bfs(graph: Graph, source: Int) {
        let queue = LinkedListQueue<Int>()
        queue.enqueue(source)
        marked[source] = true
        color[source] = false
        
        while let v = queue.dequeue() {
            for w in graph.adjacent(to: v) {
                if !marked[w] {
                    marked[w] = true
                    edgeTo[w] = v
                    color[w] = !color[v]
                    queue.enqueue(w)
                }
                else if color[w] == color[v] {
                    isBipartite = false
                    cycle = getOddCycle(from: v, to: w)
                    return
                }
            }
        }
    }
    
    // Retrace paths from source and destination until common vertex x is found.
    // (destination-x) + (x-source) + (source-destination) is an odd-length cycle.
    private func getOddCycle(from source: Int, to destination: Int) -> [Int] {
        var path = [Int]()
        var stack = [Int]()
        var x = source
        var y = destination

        while x != y {
            stack.append(x)
            path.append(y)
            x = edgeTo[x]!
            y = edgeTo[y]!
        }

        stack.append(x)
        path.append(contentsOf: stack.reversed())
        path.append(destination)

        return path
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
