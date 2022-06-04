//
//  EdgeWeightedGraph.swift
//  Created by hg on 12/03/2022.
//

import Foundation

public class EdgeWeightedGraph: Graph {
    
    private var edges: Int
    private var adjacencyList: [[WeightedEdge]]
    
    public init(vertices: Int) {
        self.edges = 0
        self.adjacencyList = [[WeightedEdge]](repeating: [], count: vertices)
    }
    
    public func addEdge(v: Int, w: Int, weight: Double) {
        let edge = WeightedEdge(v: v, w: w, weight: weight)
        adjacencyList[v].append(edge)
        adjacencyList[w].append(edge)
        edges += 1
    }
    
    public func adjacentEdges(to vertex: Int) -> [WeightedEdge] {
        return adjacencyList[vertex]
    }
    
    public func adjacent(to vertex: Int) -> [Int] {
        return adjacencyList[vertex].map(\.w)
    }
    
    public func vertexCount() -> Int {
        return adjacencyList.count
    }
    
    public func edgeCount() -> Int {
        return edges
    }
    
    public func degree(of vertex: Int) -> Int {
        return adjacencyList[vertex].count
    }
    
    public func getEdges() -> [WeightedEdge] {
        var list = [WeightedEdge]()
        
        for v in 0..<vertexCount() {
            var selfLoops = 0
            
            for edge in adjacentEdges(to: v) {
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
