//
//  FordFulkerson.swift
//  Created by hg on 26/03/2022.
//
//  O(EV (E + V))
//  O(V) space.
//

import Foundation

public class FordFulkerson {
    
    private let vertexCount: Int
    private var marked: [Bool]!
    private var edgeTo: [FlowEdge?]!
    private var flow: Decimal
    
    public init(flowNetwork: FlowNetwork, source: Int, sink: Int) {
        self.vertexCount = flowNetwork.vertexCount()
        self.flow = 0
        
        fordFulkerson(flowNetwork: flowNetwork, source: source, sink: sink)
    }
    
    private func fordFulkerson(flowNetwork: FlowNetwork, source: Int, sink: Int) {
        guard
            source != sink,
            isFeasible(flowNetwork: flowNetwork, source: source, sink: sink)
        else {
            return
        }
        
        flow = excessFlow(in: flowNetwork, at: sink)
        
        while hasAugmentingPath(flowNetwork: flowNetwork, source: source, sink: sink) {
            var bottle = Decimal.greatestFiniteMagnitude
            var v = sink
            
            while v != source {
                bottle = min(bottle, edgeTo[v]!.residualCapacity(to: v)!)
                v = edgeTo[v]!.other(vertex: v)!
            }
            
            v = sink
            while v != source {
                edgeTo[v]!.addResidualFlow(to: v, delta: bottle)
                v = edgeTo[v]!.other(vertex: v)!
            }
            
            flow += bottle
        }
    }
    
    private func hasAugmentingPath(flowNetwork: FlowNetwork, source: Int, sink: Int) -> Bool {
        marked = [Bool](repeating: false, count: vertexCount)
        edgeTo = [FlowEdge?](repeating: nil, count: vertexCount)
        
        let queue = TwoStackQueue<Int>()
        queue.enqueue(source)
        marked[source] = true
        
        while let vertex = queue.dequeue(), !marked[sink] {
            for edge in flowNetwork.adjacentEdges(to: vertex) {
                if
                    let w = edge.other(vertex: vertex),
                    edge.residualCapacity(to: w)! > 0
                {
                    if !marked[w] {
                        edgeTo[w] = edge
                        marked[w] = true
                        queue.enqueue(w)
                    }
                }
            }
        }
        
        return marked[sink]
    }
    
    private func isFeasible(flowNetwork: FlowNetwork, source: Int, sink: Int) -> Bool {
        // Check that capacity constraints are satisfied
        for vertex in 0..<flowNetwork.vertexCount() {
            for edge in flowNetwork.adjacentEdges(to: vertex) {
                if edge.flow > edge.capacity {
                    return false
                }
            }
        }
        
        // Check that net flow into a vertex equals zero, except at source and sink
        if abs(flow + excessFlow(in: flowNetwork, at: source)) > 0 {
            return false
        }
        
        if abs(flow - excessFlow(in: flowNetwork, at: sink)) > 0 {
            return false
        }
        
        for vertex in 0..<flowNetwork.vertexCount() {
            if vertex == source || vertex == sink { continue }
            
            if abs(excessFlow(in: flowNetwork, at: vertex)) > 0 {
                return false
            }
        }
        
        return true
    }
    
    private func excessFlow(in flowNetwork: FlowNetwork, at vertex: Int) -> Decimal {
        var excess: Decimal = 0
        
        for edge in flowNetwork.adjacentEdges(to: vertex) {
            if vertex == edge.source { excess -= edge.flow }
            else { excess += edge.flow }
        }
        
        return excess
    }
    
    public func maxFlow() -> Decimal {
        return flow
    }
    
    public func isInCut(vertex: Int) -> Bool {
        return marked[vertex]
    }
    
}
