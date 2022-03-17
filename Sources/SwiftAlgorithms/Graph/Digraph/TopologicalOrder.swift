//
//  GraphTopologicalOrder.swift
//  Created by hg on 07/03/2022.
//
//  A topological ordering of a directed graph is a linear ordering of its vertices such that for every directed edge uv from vertex u to vertex v, u comes before v in the ordering.
//  A topological ordering is possible iff the graph has no directed cycles, that is, if it is a directed acyclic graph (DAG).
//  O(V + E) time worst case.
//  O(V) space.

import Foundation

public class TopologicalOrder {
    
    public init() {}
    
    public func getOrder(graph: Digraph) -> [Int]? {
        guard !DirectedCycle(graph: graph).hasCycle() else { return nil }
        return DepthFirstOrder(graph: graph).getReversePostorder()
    }
    
}
