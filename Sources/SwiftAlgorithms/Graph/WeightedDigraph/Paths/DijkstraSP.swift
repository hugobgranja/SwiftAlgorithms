//
//  DijkstraSP.swift
//  Created by hg on 20/03/2022.
//
//  Computes the shortest path tree using Dijkstra's algorithm.
//  Assumes all weights are non-negative.
//
//  O(E Log V) time worst case.
//  O(V) space.
//

import Foundation

public class DijkstraSP {
    
    private var edgeTo: [DirectedEdge?]
    private var distTo: [Double]
    private var pq: IndexedPriorityQueue<Double>
    
    public init(graph: EdgeWeightedDigraph, source: Int) {
        let count = graph.vertexCount()
        self.edgeTo = [DirectedEdge?](repeating: nil, count: count)
        self.distTo = [Double](repeating: Double.infinity, count: count)
        self.pq = IndexedPriorityQueue(length: count, isLowerPriority: { $0 > $1 })
        dijkstra(graph: graph, source: source)
    }
    
    private func dijkstra(graph: EdgeWeightedDigraph, source: Int) {
        distTo[source] = 0
        pq.enqueue(index: source, key: distTo[source])
        
        while let (v, _) = pq.dequeue() {
            for edge in graph.adjacentEdges(to: v) {
                relax(edge)
            }
        }
    }
    
    private func relax(_ edge: DirectedEdge) {
        let source = edge.source
        let dest = edge.destination
        let distance = distTo[source] + edge.weight
        
        if distTo[dest] > distance {
            distTo[dest] = distance
            edgeTo[dest] = edge
            
            if pq.contains(index: dest) {
                pq.decreaseKey(index: dest, key: distance)
            }
            else {
                pq.enqueue(index: dest, key: distance)
            }
        }
    }
    
    public func distance(to vertex: Int) -> Double {
        return distTo[vertex]
    }
    
    public func hasPath(to vertex: Int) -> Bool {
        return distTo[vertex] < Double.infinity
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
