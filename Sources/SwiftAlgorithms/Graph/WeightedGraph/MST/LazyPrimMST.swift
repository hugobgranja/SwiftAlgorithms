//
//  LazyPrimMST.swift
//  Created by hg on 13/03/2022.
//
//  Computes the minimum spanning tree of a edge-weighted graph using a lazy version of Prim's algorithm.
//  O(E Log E) time worst case.
//  O(E) space worst case.

import Foundation

public class LazyPrimMST: MST {
    
    private var marked: [Bool]
    private var pq: MinBinaryHeap<WeightedEdge>
    private var mst: [WeightedEdge]
    private var weight: Decimal
    
    public init(graph: EdgeWeightedGraph) {
        self.marked = [Bool](repeating: false, count: graph.vertexCount())
        self.pq = MinBinaryHeap()
        self.mst = []
        self.weight = 0
        findMST(graph: graph)
    }
    
    private func findMST(graph: EdgeWeightedGraph) {
        for v in 0..<graph.vertexCount() {
            if !marked[v] { prim(graph: graph, source: v) }
        }
    }
    
    private func prim(graph: EdgeWeightedGraph, source: Int) {
        marked[source] = true
        addAdjVerticesToPQ(graph: graph, vertex: source)
        
        while let edge = pq.dequeue() {
            guard !marked[edge.v] || !marked[edge.w] else { continue }
            
            mst.append(edge)
            weight += Decimal(edge.weight)
            
            if !marked[edge.v] {
                marked[edge.v] = true
                addAdjVerticesToPQ(graph: graph, vertex: edge.v)
            }
            
            if !marked[edge.w] {
                marked[edge.w] = true
                addAdjVerticesToPQ(graph: graph, vertex: edge.w)
            }
        }
    }
    
    private func addAdjVerticesToPQ(graph: EdgeWeightedGraph, vertex: Int) {
        for edge in graph.adjacent(to: vertex) {
            if let other = edge.other(vertex: vertex), !marked[other] {
                pq.enqueue(edge)
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
