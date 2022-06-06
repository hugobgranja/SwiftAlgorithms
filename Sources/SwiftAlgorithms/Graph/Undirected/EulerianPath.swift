//
//  EulerianPath.swift
//  Created by hg on 04/03/2022.
//
//  An Eulerian path is a path in a finite graph that visits every edge exactly once.
//  An undirected graph has an Eulerian path iff:
//  1. Exactly zero or two vertices have odd degree.
//  2. All of its vertices with nonzero degree belong to a single connected component.
//  Note that only one vertex with odd degree is not possible in an undirected graph, the sum of all degrees is always even in an undirected graph.
//  O(V + E) time worst case.
//  O(V + E) space worst case.
//

import Foundation

public class EulerianPath {
    
    public init() {}
    
    public func findEulerianPath(graph: UndirectedGraph) -> [Int]? {
        guard countOddDegreeVertices(graph: graph) <= 2 else { return nil }
        
        let source = findOddDegreeVertex(graph: graph) ??
            findNonIsolatedVertex(graph: graph) ?? 0
        
        var adj = createAuxAdjList(graph: graph)
        
        var stack = ArrayStack<Int>([source])
        var path = [Int]()
        
        while var v = stack.pop() {
            while let edge = adj[v].popLast() {
                guard !edge.isUsed else { continue }
                edge.isUsed = true
                stack.push(v)
                v = edge.getOther(vertex: v)!
            }
            
            path.append(v)
        }
        
        return isEveryEdgeUsed(of: graph, in: path) ? path : nil
    }
    
    private func countOddDegreeVertices(graph: UndirectedGraph) -> Int {
        var count = 0
        
        for v in 0..<graph.vertexCount() {
            if !graph.degree(of: v).isMultiple(of: 2) {
                count += 1
            }
        }
        
        return count
    }
    
    private func findOddDegreeVertex(graph: UndirectedGraph) -> Int? {
        for v in 0..<graph.vertexCount() {
            if !graph.degree(of: v).isMultiple(of: 2) {
                return v
            }
        }
        
        return nil
    }
    
    private func findNonIsolatedVertex(graph: UndirectedGraph) -> Int? {
        for v in 0..<graph.vertexCount() {
            if graph.degree(of: v) > 0 { return v }
        }
        
        return nil
    }
    
    private func createAuxAdjList(graph: UndirectedGraph) -> [[Edge]] {
        var adj = [[Edge]](repeating: [], count: graph.vertexCount())
        
        for v in 0..<graph.vertexCount() {
            var selfLoops = 0
            
            for w in graph.adjacent(to: v) {
                if v == w {
                    if selfLoops.isMultiple(of: 2) {
                        let newEdge = Edge(v: v, w: w)
                        adj[v].append(newEdge)
                        adj[w].append(newEdge)
                    }
                    selfLoops += 1
                }
                else if v < w {
                    let newEdge = Edge(v: v, w: w)
                    adj[v].append(newEdge)
                    adj[w].append(newEdge)
                }
            }
        }
        
        return adj
    }
    
    private func isEveryEdgeUsed(of graph: UndirectedGraph, in path: [Int]) -> Bool {
        return path.count == graph.edgeCount() + 1
    }
    
}

extension EulerianPath {
    
    class Edge {
        let v: Int
        let w: Int
        var isUsed: Bool
        
        init(v: Int, w: Int) {
            self.v = v
            self.w = w
            self.isUsed = false
        }
        
        func getOther(vertex: Int) -> Int? {
            if vertex == v { return w }
            if vertex == w { return v }
            return nil
        }
    }
    
}
