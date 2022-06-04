//
//  FlowNetwork.swift
//  Created by hg on 12/03/2022.
//

import Foundation

public class FlowNetwork {
    
    private var edges: Int
    private var adjacencyList: [[FlowEdge]]
    
    public init(vertices: Int) {
        self.edges = 0
        self.adjacencyList = [[FlowEdge]](repeating: [], count: vertices)
    }
    
    public func addEdge(_ edge: FlowEdge) {
        adjacencyList[edge.source].append(edge)
        adjacencyList[edge.destination].append(edge)
        edges += 1
    }
    
    public func adjacentEdges(to vertex: Int) -> [FlowEdge] {
        return adjacencyList[vertex]
    }
    
    public func vertexCount() -> Int {
        return adjacencyList.count
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
