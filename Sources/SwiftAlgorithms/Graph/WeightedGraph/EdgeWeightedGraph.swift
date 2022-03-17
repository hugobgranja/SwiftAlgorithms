//
//  EdgeWeightedGraph.swift
//  Created by hg on 12/03/2022.
//

import Foundation

public class EdgeWeightedGraph {
    
    private var edges: Int
    private var adjacencyLists: [[WeightedEdge]]
    
    public init(vertices: Int) {
        self.edges = 0
        self.adjacencyLists = [[WeightedEdge]](repeating: [], count: vertices)
    }
    
    public func addEdge(v: Int, w: Int, weight: Double) {
        let edge = WeightedEdge(v: v, w: w, weight: weight)
        adjacencyLists[v].append(edge)
        adjacencyLists[w].append(edge)
        edges += 1
    }
    
    public func adjacent(to vertex: Int) -> [WeightedEdge] {
        return adjacencyLists[vertex]
    }
    
    public func vertexCount() -> Int {
        return adjacencyLists.count
    }
    
    public func edgeCount() -> Int {
        return edges
    }
    
    public func degree(of vertex: Int) -> Int {
        return adjacencyLists[vertex].count
    }
    
    public func getEdges() -> [WeightedEdge] {
        var list = [WeightedEdge]()
        
        for v in 0..<vertexCount() {
            var selfLoops = 0
            
            for edge in adjacent(to: v) {
                let other = edge.other(vertex: v)!
                
                if other > v {
                    list.append(edge)
                }
                else if other == v {
                    if selfLoops.isMultiple(of: 2) {
                        list.append(edge)
                    }
                    
                    selfLoops += 1
                }
            }
        }
        
        return list
    }
    
}
