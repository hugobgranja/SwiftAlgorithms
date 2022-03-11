//
//  GabowSCC.swift
//  Created by hg on 09/03/2022.
//
//  Computes the strongly-connected components of a digraph using Gabow's algorithm.
//  Vertices v and w are strongly connected if there is both a directed path from v to w and a directed path from w to v.
//  O(V + E) time.
//  O(V) space.
//

import Foundation

public class GabowSCC: SCC {
    
    private var marked: [Bool]
    private var id: [Int]
    private var preorder: [Int]
    private var pre: Int
    private var componentsCount: Int
    private var stack1: ArrayStack<Int>
    private var stack2: ArrayStack<Int>
    
    public init(graph: Digraph) {
        let vertexCount = graph.vertexCount()
        marked = [Bool](repeating: false, count: vertexCount)
        id = [Int](repeating: -1, count: vertexCount)
        preorder = [Int](repeating: 0, count: vertexCount)
        pre = 0
        componentsCount = 0
        stack1 = ArrayStack()
        stack2 = ArrayStack()
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
        preorder[source] = pre
        pre += 1
        stack1.push(source)
        stack2.push(source)
        
        for vertex in graph.adjacent(to: source) {
            if !marked[vertex] {
                dfs(graph: graph, source: vertex)
            }
            else if id[vertex] == -1 {
                while let element = stack2.peek(), preorder[element] > preorder[vertex] {
                    _ = stack2.pop()
                }
            }
        }
        
        if stack2.peek() == source {
            _ = stack2.pop()
            var vertex: Int
            
            repeat {
                vertex = stack1.pop()!
                id[vertex] = componentsCount
            } while vertex != source
            
            componentsCount += 1
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
