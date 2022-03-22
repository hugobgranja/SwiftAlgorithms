//
//  BellmanFordSP.swift
//  Created by hg on 20/03/2022.
//
//  Computes the shortest path tree or finds a negative cost cycle.
//
//  O(VE) time worst case.
//  O(V) space.
//

import Foundation

public class BellmanFordSP {
    
    private var edgeTo: [DirectedEdge?]
    private var distTo: [Double]
    private var onQueue: [Bool]
    private var queue: TwoStackQueue<Int>
    private var cost: Int
    private var cycle: [Int]
    
    public init(graph: EdgeWeightedDigraph, source: Int) {
        let count = graph.vertexCount()
        self.edgeTo = [DirectedEdge?](repeating: nil, count: count)
        self.distTo = [Double](repeating: Double.infinity, count: count)
        self.onQueue = [Bool](repeating: false, count: count)
        self.queue = TwoStackQueue()
        self.cost = 0
        self.cycle = [Int]()
        distTo[source] = 0
        
        bellmanFordSP(graph: graph, source: source)
    }
    
    private func bellmanFordSP(graph: EdgeWeightedDigraph, source: Int) {
        queue.enqueue(source)
        onQueue[source] = true
        
        while let vertex = queue.dequeue(), !hasNegativeCycle() {
            onQueue[vertex] = false
            relax(graph: graph, vertex: vertex)
        }
    }
    
    private func relax(graph: EdgeWeightedDigraph, vertex: Int) {
        for edge in graph.adjacentEdges(to: vertex) {
            let distance = distTo[edge.source] + edge.weight
            
            if distTo[edge.destination] > distance {
                distTo[edge.destination] = distance
                edgeTo[edge.destination] = edge
                
                if !onQueue[edge.destination] {
                    queue.enqueue(edge.destination)
                    onQueue[edge.destination] = true
                }
            }
            
            cost += 1
            if cost.isMultiple(of: graph.vertexCount()) {
                findNegativeCycle()
                if hasNegativeCycle() { return }
            }
        }
        
    }
    
    private func findNegativeCycle() {
        let verticesCount = edgeTo.count
        let spt = EdgeWeightedDigraph(vertices: verticesCount)
        
        for vertex in 0..<verticesCount {
            if let someEdge = edgeTo[vertex] {
                spt.addEdge(
                    from: someEdge.source,
                    to: someEdge.destination,
                    weight: someEdge.weight
                )
            }
        }
        
        let cycleFinder = DirectedCycle(graph: spt)
        cycle = cycleFinder.getCycle()
    }
    
    public func distance(to vertex: Int) -> Double? {
        guard !hasNegativeCycle() else { return nil }
        return distTo[vertex]
    }
    
    public func hasPath(to vertex: Int) -> Bool {
        return distTo[vertex] < Double.infinity
    }
    
    public func path(to vertex: Int) -> [DirectedEdge]? {
        guard !hasNegativeCycle(), hasPath(to: vertex) else { return nil }
        
        var path = [DirectedEdge]()
        var edge = edgeTo[vertex]
        
        while let someEdge = edge {
            path.append(someEdge)
            edge = edgeTo[someEdge.source]
        }
        
        return path.reversed()
    }
    
    public func hasNegativeCycle() -> Bool {
        return !cycle.isEmpty
    }
    
    public func getNegativeCycle() -> [Int] {
        return cycle
    }
    
}
