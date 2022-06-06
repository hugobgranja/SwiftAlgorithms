//
//  EulerianCycle.swift
//  Created by hg on 06/03/2022.
//
//  An Eulerian cycle is an Eulerian path that starts and ends on the same vertex.
//  An undirected graph has an Eulerian cycle iff:
//  1. Every vertex has even degree.
//  2. All of its vertices with nonzero degree belong to a single connected component.
//  O(V + E) time worst case.
//  O(V + E) space worst case.
//

import Foundation

public class EulerianCycle {
    
    public init() {}
    
    public func findEulerianCycle(graph: UndirectedGraph) -> [Int]? {
        guard
            graph.edgeCount() > 0,
            hasEveryVertexEvenDegree(graph: graph)
        else {
            return nil
        }

        let source = findNonIsolatedVertex(graph: graph) ?? 0
        var adj = createAuxAdjList(graph: graph)
        
        var stack = ArrayStack<Int>([source])
        var cycle = [Int]()
        
        while var v = stack.pop() {
            while let edge = adj[v].popLast() {
                guard !edge.isUsed else { continue }
                edge.isUsed = true
                stack.push(v)
                v = edge.getOther(vertex: v)!
            }
            
            cycle.append(v)
        }
        
        return isEveryEdgeUsed(of: graph, in: cycle) ? cycle : nil
    }
    
    private func hasEveryVertexEvenDegree(graph: UndirectedGraph) -> Bool {
        for v in 0..<graph.vertexCount() {
            if !graph.degree(of: v).isMultiple(of: 2) {
                return false
            }
        }
        
        return true
    }
    
    private func findNonIsolatedVertex(graph: UndirectedGraph) -> Int? {
        for v in 0..<graph.vertexCount() {
            if graph.degree(of: v) > 0 { return v }
        }
        
        return nil
    }
    
    private func createAuxAdjList(graph: Graph) -> [[Edge]] {
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

extension EulerianCycle {
    
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
