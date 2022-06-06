//
//  DirectedEulerianPath.swift
//  Created by hg on 07/03/2022.
//
//  An Eulerian path is a path in a finite graph that visits every edge exactly once.
//  A directed graph has an Eulerian path iff:
//  At most one vertex has outdegree - indegree = 1.
//  At most one vertex has indegree - outdegree = 1.
//  Every other vertex has equal indegree and outdegree.
//  All of its vertices with nonzero degree belong to a single connected component.
//  O(V + E) time worst case.
//  O(V) space.
//

import Foundation

public class DirectedEulerianPath {
    
    public init() {}
    
    public func findEulerianPath(graph: Digraph) -> [Int]? {
        if degreeDifferential(graph: graph) > 1 { return nil }
        
        let source = findLargerOutdegreeVertex(graph: graph) ??
            findNonIsolatedVertex(graph: graph) ?? 0
        
        var adj = createAuxAdjList(graph: graph)
        
        var stack = ArrayStack<Int>([source])
        var path = [Int]()
        
        while var v = stack.pop() {
            while let w = adj[v].next() {
                stack.push(v)
                v = w
            }
            
            path.append(v)
        }
        
        return isEveryEdgeUsed(of: graph, in: path) ? path.reversed() : nil
    }
    
    private func degreeDifferential(graph: Digraph) -> Int {
        var diff = 0
        
        for v in 0..<graph.vertexCount() {
            if graph.outdegree(of: v) > graph.indegree(of: v) {
                diff += graph.outdegree(of: v) - graph.indegree(of: v)
            }
        }
        
        return diff
    }
    
    private func findLargerOutdegreeVertex(graph: Digraph) -> Int? {
        for v in 0..<graph.vertexCount() {
            if graph.outdegree(of: v) > graph.indegree(of: v) {
                return v
            }
        }
        
        return nil
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
