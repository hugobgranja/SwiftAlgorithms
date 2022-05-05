//
//  BoruvkaMST.swift
//  Created by hg on 13/03/2022.
//
//  Computes the minimum spanning tree of a edge-weighted graph using Boruvka's algorithm.
//  O(E Log V) time worst case.
//  O(V) space.

import Foundation

public class BoruvkaMST: MST {
    
    private var mst: [WeightedEdge]
    private var weight: Decimal
    
    public init(graph: EdgeWeightedGraph) {
        self.mst = []
        self.weight = 0
        findMST(graph: graph)
    }
    
    private func findMST(graph: EdgeWeightedGraph) {
        let uf = WQURankUF(length: graph.vertexCount())
        var t = 1
        
        while t < graph.vertexCount() && mst.count < graph.vertexCount() - 1 {
            var closest = [WeightedEdge?](repeating: nil, count: graph.vertexCount())
            
            for edge in graph.getEdges() {
                let i = uf.find(edge.v)
                let j = uf.find(edge.w)
                
                if i == j { continue }
                
                if closest[i] == nil || edge < closest[i]! { closest[i] = edge }
                if closest[j] == nil || edge < closest[j]! { closest[j] = edge }
            }
            
            for i in 0..<graph.vertexCount() {
                if let edge = closest[i] {
                    if uf.find(edge.v) != uf.find(edge.w) {
                        mst.append(edge)
                        weight += Decimal(edge.weight)
                        uf.union(edge.v, edge.w)
                    }
                }
            }
            
            t += t
        }
    }
    
    public func getMST() -> [WeightedEdge] {
        return mst
    }
    
    public func getWeight() -> Double {
        return NSDecimalNumber(decimal: weight).doubleValue
    }
    
}
