//
//  PrimMST.swift
//  Created by hg on 13/03/2022.
//
//  Computes the minimum spanning tree of a edge-weighted graph using Prim's algorithm.
//  O(E Log V) time worst case.
//  O(V) space.

import Foundation

public class PrimMST: MST {
    
    private var marked: [Bool]
    private var edgeTo: [WeightedEdge?]
    private var distTo: [Double]
    private var pq: IndexedPriorityQueue<Double>
    
    public init(graph: EdgeWeightedGraph) {
        let count = graph.vertexCount()
        self.marked = [Bool](repeating: false, count: count)
        self.edgeTo = [WeightedEdge?](repeating: nil, count: count)
        self.distTo = [Double](repeating: Double.infinity, count: count)
        self.pq = IndexedPriorityQueue(length: count, isLowerPriority: { $0 > $1 })
        findMST(graph: graph)
    }
    
    private func findMST(graph: EdgeWeightedGraph) {
        for v in 0..<graph.vertexCount() {
            if !marked[v] { prim(graph: graph, source: v) }
        }
    }
    
    private func prim(graph: EdgeWeightedGraph, source: Int) {
        distTo[source] = 0
        pq.enqueue(index: source, key: distTo[source])
        
        while let (v, _) = pq.dequeue() {
            scan(graph: graph, v: v)
        }
    }
    
    private func scan(graph: EdgeWeightedGraph, v: Int) {
        marked[v] = true
        
        for edge in graph.adjacent(to: v) {
            guard let w = edge.other(vertex: v), !marked[w] else { continue }
            
            if edge.weight < distTo[w] {
                distTo[w] = edge.weight
                edgeTo[w] = edge
                
                if pq.contains(index: w) {
                    pq.decreaseKey(index: w, key: distTo[w])
                }
                else {
                    pq.enqueue(index: w, key: distTo[w])
                }
            }
        }
    }
    
    public func getMST() -> [WeightedEdge] {
        var mst = [WeightedEdge]()
        
        for v in 0..<edgeTo.count {
            if let edge = edgeTo[v] {
                mst.append(edge)
            }
        }
        
        return mst
    }
    
    public func getWeight() -> Double {
        var weight: Decimal = 0
        
        for edge in getMST() {
            weight += Decimal(edge.weight)
        }
        
        return NSDecimalNumber(decimal: weight).doubleValue
    }
    
}
