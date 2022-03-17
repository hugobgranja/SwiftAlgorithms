//
//  DirectedCycle.swift
//  Created by hg on 07/03/2022.
//
//  O(V + E) time worst case.
//  O(V) space.
//

import Foundation

public class DirectedCycle {
    
    private var marked: [Bool]
    private var edgeTo: [Int?]
    private var onStack: [Bool]
    private var cycle: [Int]
    
    public init(graph: Graph) {
        let count = graph.vertexCount()
        marked = [Bool](repeating: false, count: count)
        edgeTo = [Int?](repeating: nil, count: count)
        onStack = [Bool](repeating: false, count: count)
        cycle = [Int]()
        findCycle(graph: graph)
    }
    
    private func findCycle(graph: Graph) {
        for vertex in 0..<graph.vertexCount() {
            guard !hasCycle() else { return }
            if !marked[vertex] { dfs(graph: graph, v: vertex) }
        }
    }
    
    private func dfs(graph: Graph, v: Int) {
        onStack[v] = true
        marked[v] = true
        
        for w in graph.adjacent(to: v) {
            guard !hasCycle() else { return }
            
            if !marked[w] {
                edgeTo[w] = v
                dfs(graph: graph, v: w)
            }
            else if onStack[w] {
                cycle = path(from: v, to: w)
                cycle.append(w)
            }
        }
        
        onStack[v] = false
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
