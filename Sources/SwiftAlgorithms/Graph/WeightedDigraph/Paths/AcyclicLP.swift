//
//  AcyclicLP.swift
//  Created by hg on 20/03/2022.
//
//  Computes the longest path tree.
//  Assumes graph is acyclic.
//
//  O(V + E) time worst case.
//  O(V) space.
//

import Foundation

public class AcyclicLP {
    
    private var edgeTo: [DirectedEdge?]
    private var distTo: [Double]
    
    public init(graph: EdgeWeightedDigraph, source: Int) {
        let count = graph.vertexCount()
        self.edgeTo = [DirectedEdge?](repeating: nil, count: count)
        self.distTo = [Double](repeating: -Double.infinity, count: count)
        distTo[source] = 0
        
        if let topologicalOrder = TopologicalOrder().getOrder(graph: graph) {
            acyclicSP(graph: graph, order: topologicalOrder)
        }
    }
    
    private func acyclicSP(graph: EdgeWeightedDigraph, order: [Int]) {
        for vertex in order {
            for edge in graph.adjacentEdges(to: vertex) {
                relax(edge)
            }
        }
    }
    
    private func relax(_ edge: DirectedEdge) {
        let distance = distTo[edge.source] + edge.weight
        
        if distTo[edge.destination] < distance {
            distTo[edge.destination] = distance
            edgeTo[edge.destination] = edge
        }
    }
    
    public func distance(to vertex: Int) -> Double {
        return distTo[vertex]
    }
    
    public func hasPath(to vertex: Int) -> Bool {
        return distTo[vertex] > -Double.infinity
    }
    
    public func path(to vertex: Int) -> [DirectedEdge]? {
        guard hasPath(to: vertex) else { return nil }
        
        var path = [DirectedEdge]()
        var edge = edgeTo[vertex]
        
        while let someEdge = edge {
            path.append(someEdge)
            edge = edgeTo[someEdge.source]
        }
        
        return path.reversed()
    }
    
}
