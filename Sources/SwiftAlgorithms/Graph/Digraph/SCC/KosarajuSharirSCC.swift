//
//  KosarajuSharirSCC.swift
//  Created by hg on 09/03/2022.
//
//  Computes the strongly-connected components of a digraph using the Kosaraju-Sharir algorithm.
//  Vertices v and w are strongly connected if there is both a directed path from v to w and a directed path from w to v.
//  O(V + E) time.
//  O(V) space.
//

import Foundation

public class KosarajuSharirSCC: SCC {
    
    private var marked: [Bool]
    private var id: [Int]
    private var componentsCount: Int
    
    public init(graph: Digraph) {
        let vertexCount = graph.vertexCount()
        marked = [Bool](repeating: false, count: vertexCount)
        id = [Int](repeating: -1, count: vertexCount)
        componentsCount = 0
        findSCCs(graph: graph)
    }
    
    private func findSCCs(graph: Digraph) {
        let dfo = DepthFirstOrder(graph: graph.reversed())
        
        for v in dfo.getReversePostorder() {
            if !marked[v] {
                dfs(graph: graph, source: v)
                componentsCount += 1
            }
        }
    }
    
    private func dfs(graph: Graph, source: Int) {
        marked[source] = true
        id[source] = componentsCount
        
        for vertex in graph.adjacent(to: source) {
            if !marked[vertex] { dfs(graph: graph, source: vertex) }
        }
    }
    
    public func isStronglyConnected(v: Int, w: Int) -> Bool {
        return id(vertex: v) == id(vertex: w)
    }
    
    public func id(vertex: Int) -> Int {
        return id[vertex]
    }
    
    public func count() -> Int {
        return componentsCount
    }
    
}
