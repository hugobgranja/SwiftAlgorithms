//
//  DirectedEulerianCycle.swift
//  Created by hg on 09/03/2022.
//
//  An Eulerian cycle is an Eulerian path that starts and ends on the same vertex.
//  A directed graph has an Eulerian cycle iff:
//  Every vertex has equal indegree and outdegree.
//  All of its vertices with nonzero degree belong to a single connected component.
//  O(V + E) time worst case.
//  O(V) space.
//

import Foundation

public class DirectedEulerianCycle {
    
    public init() {}
    
    public func findEulerianCycle(graph: Digraph) -> [Int]? {
        guard graph.edgeCount() > 0 && isBalanced(graph: graph) else { return nil }
        
        let source = findNonIsolatedVertex(graph: graph) ?? 0
        
        var adj = createAuxAdjList(graph: graph)
        
        let stack = ArrayStack<Int>([source])
        var cycle = [Int]()
        
        while var v = stack.pop() {
            while let w = adj[v].next() {
                stack.push(v)
                v = w
            }
            
            cycle.append(v)
        }
        
        return isEveryEdgeUsed(of: graph, in: cycle) ? cycle.reversed() : nil
    }
    
    private func isBalanced(graph: Digraph) -> Bool {
        for v in 0..<graph.vertexCount() {
            if graph.outdegree(of: v) != graph.indegree(of: v) {
                return false
            }
        }
        
        return true
    }
    
    private func findNonIsolatedVertex(graph: Digraph) -> Int? {
        for v in 0..<graph.vertexCount() {
            if graph.outdegree(of: v) > 0 { return v }
        }
        
        return nil
    }
    
    private func createAuxAdjList(graph: Digraph) -> [IndexingIterator<[Int]>] {
        var adj = [IndexingIterator<[Int]>]()
        
        for v in 0..<graph.vertexCount() {
            adj.append(graph.adjacent(to: v).makeIterator())
        }
        
        return adj
    }
    
    private func isEveryEdgeUsed(of graph: Digraph, in path: [Int]) -> Bool {
        return path.count == graph.edgeCount() + 1
    }
    
}
