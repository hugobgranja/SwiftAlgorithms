//
//  Cycle.swift
//  Created by hg on 27/03/2021.
//
//  O(V + E) time worst case.
//  O(V) space.
//

import Foundation

public class Cycle {
    
    private var marked: [Bool]
    private var edgeTo: [Int?]
    private var cycle: [Int]
    
    public init(graph: UndirectedGraph) {
        let count = graph.vertexCount()
        marked = [Bool](repeating: false, count: count)
        edgeTo = [Int?](repeating: nil, count: count)
        cycle = [Int]()
        findCycle(graph: graph)
    }
    
    private func findCycle(graph: Graph) {
        findSelfLoop(graph: graph)
        
        if !hasCycle() {
            findParallelEdges(graph: graph)
        }
        
        if !hasCycle() {
            for vertex in 0..<graph.vertexCount() where !hasCycle() {
                if !marked[vertex] { dfs(graph: graph, -1, vertex) }
            }
        }
    }
    
    private func findSelfLoop(graph: Graph) {
        for v in 0..<graph.vertexCount() {
            for w in graph.adjacent(to: v) {
                if v == w {
                    cycle.append(v)
                    cycle.append(v)
                    return
                }
            }
        }
    }
    
    private func findParallelEdges(graph: Graph) {
        for v in 0..<graph.vertexCount() where !hasCycle() {
            for w in graph.adjacent(to: v) {
                if marked[w] {
                    cycle.append(v)
                    cycle.append(w)
                    cycle.append(v)
                    break
                }
                
                marked[w] = true
            }
            
            for w in graph.adjacent(to: v) {
                marked[w] = false
            }
        }
    }
    
    private func dfs(graph: Graph, _ u: Int, _ v: Int) {
        marked[v] = true
        
        for w in graph.adjacent(to: v) where !hasCycle() {
            if !marked[w] {
                edgeTo[w] = v
                dfs(graph: graph, v, w)
            }
            else if w != u {
                cycle.append(v)
                cycle += path(from: v, to: w)
            }
        }
    }
    
    private func path(from source: Int, to destination: Int) -> [Int] {
        var path = [Int]()
        var x = source
        
        while x != destination {
            path.append(x)
            x = edgeTo[x]!
        }
        
        path.append(destination)
        
        return path.reversed()
    }
    
    public func hasCycle() -> Bool {
        return !cycle.isEmpty
    }
    
    public func getCycle() -> [Int] {
        return cycle
    }
    
}
