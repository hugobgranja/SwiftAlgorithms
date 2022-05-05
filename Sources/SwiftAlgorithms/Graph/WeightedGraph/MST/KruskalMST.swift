//
//  KruskalMST.swift
//  Created by hg on 13/03/2022.
//
//  Computes the minimum spanning tree of a edge-weighted graph using Kruskal's algorithm.
//  O(E Log E) time worst case.
//  O(E) space.

import Foundation

public class KruskalMST: MST {
    
    private var mst: [WeightedEdge]
    private var weight: Decimal
    
    public init(graph: EdgeWeightedGraph) {
        self.mst = []
        self.weight = 0
        findMST(graph: graph)
    }
    
    private func findMST(graph: EdgeWeightedGraph) {
        var sortedEdges = graph.getEdges().sorted(by: >)
        let uf = WQURankUF(length: graph.vertexCount())
        
        while let edge = sortedEdges.popLast(), mst.count < graph.vertexCount() - 1 {
            if !uf.connected(edge.v, edge.w) {
                uf.union(edge.v, edge.w)
                mst.append(edge)
                weight += Decimal(edge.weight)
            }
        }
    }
    
    public func getMST() -> [WeightedEdge] {
        return mst
    }
    
    public func getWeight() -> Double {
        return NSDecimalNumber(decimal: weight).doubleValue
    }
    
}
