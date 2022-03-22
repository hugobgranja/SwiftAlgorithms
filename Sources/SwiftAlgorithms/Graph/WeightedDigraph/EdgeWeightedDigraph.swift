//
//  EdgeWeightedDigraph.swift
//  Created by hg on 12/03/2022.
//

import Foundation

public class EdgeWeightedDigraph: Graph {
    
    private var edges: Int
    private var adjacencyLists: [[DirectedEdge]]
    private var indegree: [Int]
    
    public init(vertices: Int) {
        self.edges = 0
        self.adjacencyLists = [[DirectedEdge]](repeating: [], count: vertices)
        self.indegree = [Int](repeating: 0, count: vertices)
    }
    
    public func addEdge(from source: Int, to destination: Int, weight: Double) {
        let edge = DirectedEdge(from: source, to: destination, weight: weight)
        adjacencyLists[source].append(edge)
        edges += 1
        indegree[destination] += 1
    }
    
    public func adjacentEdges(to vertex: Int) -> [DirectedEdge] {
        return adjacencyLists[vertex]
    }
    
    public func adjacent(to vertex: Int) -> [Int] {
        return adjacencyLists[vertex].map { $0.destination }
    }
    
    public func vertexCount() -> Int {
        return adjacencyLists.count
    }
    
    public func edgeCount() -> Int {
        return edges
    }
    
    public func outdegree(of vertex: Int) -> Int {
        return adjacencyLists[vertex].count
    }
    
    public func indegree(of vertex: Int) -> Int {
        return indegree[vertex]
    }
    
    public func getEdges() -> [DirectedEdge] {
        return adjacencyLists.flatMap { $0 }
    }
    
    public func reversed() -> EdgeWeightedDigraph {
        let reversed = EdgeWeightedDigraph(vertices: vertexCount())
        
        for v in 0..<vertexCount() {
            for edge in adjacentEdges(to: v) {
                reversed.addEdge(
                    from: edge.destination,
                    to: edge.source,
                    weight: edge.weight
                )
            }
        }
        
        return reversed
    }
    
}
