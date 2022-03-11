//
//  TarjanSCC.swift
//  Created by hg on 09/03/2022.
//
//  Computes the strongly-connected components of a digraph using Tarjan's algorithm.
//  Vertices v and w are strongly connected if there is both a directed path from v to w and a directed path from w to v.
//  O(V + E) time.
//  O(V) space.
//

import Foundation

public class TarjanSCC: SCC {
    
    private var marked: [Bool]
    private var id: [Int]
    private var low: [Int]
    private var pre: Int
    private var componentsCount: Int
    private var stack: ArrayStack<Int>
    
    public init(graph: Digraph) {
        let vertexCount = graph.vertexCount()
        marked = [Bool](repeating: false, count: vertexCount)
        id = [Int](repeating: 0, count: vertexCount)
        low = [Int](repeating: 0, count: vertexCount)
        pre = 0
        componentsCount = 0
        stack = ArrayStack()
        findSCCs(graph: graph)
    }
    
    private func findSCCs(graph: Digraph) {
        for v in 0..<graph.vertexCount() {
            if !marked[v] {
                dfs(graph: graph, source: v)
            }
        }
    }
    
    private func dfs(graph: Graph, source: Int) {
        marked[source] = true
        low[source] = pre
        pre += 1
        var min = low[source]
        stack.push(source)
        
        for vertex in graph.adjacent(to: source) {
            if !marked[vertex] { dfs(graph: graph, source: vertex) }
            if low[vertex] < min { min = low[vertex] }
        }
        
        if min < low[source] {
            low[source] = min
            return
        }
        
        var w: Int
        repeat {
            w = stack.pop()!
            id[w] = componentsCount
            low[w] = graph.vertexCount()
        } while w != source
        
        componentsCount += 1
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
