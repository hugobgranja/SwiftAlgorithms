//
//  DepthFirstOrder.swift
//  Created by hg on 07/03/2022.
//
//  Determines depth-first search ordering of the vertices in a digraph.
//  O(V + E) time.
//  O(V) space.

import Foundation

public class DepthFirstOrder {
    
    private var marked: [Bool]
    private var preorder: [Int]
    private var postorder: [Int]
    
    public init(graph: Graph) {
        let count = graph.vertexCount()
        self.marked = [Bool](repeating: false, count: count)
        self.preorder = []
        self.postorder = []
        findOrder(graph: graph)
    }
    
    private func findOrder(graph: Graph) {
        for v in 0..<graph.vertexCount() {
            if !marked[v] { dfs(graph: graph, source: v) }
        }
    }
    
    private func dfs(graph: Graph, source: Int) {
        marked[source] = true
        preorder.append(source)
        
        for vertex in graph.adjacent(to: source) {
            if !marked[vertex] {
                dfs(graph: graph, source: vertex)
            }
        }
        
        postorder.append(source)
    }
    
    public func getPreorder() -> [Int] {
        return preorder
    }
    
    public func getPostorder() -> [Int] {
        return postorder
    }
    
    public func getReversePostorder() -> [Int] {
        return getPostorder().reversed()
    }
    
}
