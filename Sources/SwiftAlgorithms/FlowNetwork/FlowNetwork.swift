//
//  FlowNetwork.swift
//  Created by hg on 12/03/2022.
//

import Foundation

public class FlowNetwork {
    
    private var edges: Int
    private var adjacencyLists: [[FlowEdge]]
    
    public init(vertices: Int) {
        self.edges = 0
        self.adjacencyLists = [[FlowEdge]](repeating: [], count: vertices)
    }
    
    public func addEdge(_ edge: FlowEdge) {
        adjacencyLists[edge.source].append(edge)
        adjacencyLists[edge.destination].append(edge)
        edges += 1
    }
    
    public func adjacentEdges(to vertex: Int) -> [FlowEdge] {
        return adjacencyLists[vertex]
    }
    
    public func vertexCount() -> Int {
        return adjacencyLists.count
    }
    
    public func edgeCount() -> Int {
        return edges
    }
    
    public func getEdges() -> [FlowEdge] {
        var list = [FlowEdge]()
        
        for vertex in 0..<vertexCount() {
            for edge in adjacentEdges(to: vertex) {
                if edge.destination != vertex {
                    list.append(edge)
                }
            }
        }
        
        return list
    }
    
}
