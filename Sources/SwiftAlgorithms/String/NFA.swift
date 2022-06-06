//
//  NFA.swift
//  Created by hg on 12/04/2022.
//

import Foundation

public class NFA {
    
    private let regex: [Character]
    private let graph: Digraph
    private let metacharacters: [Character]
    
    public init(regex: String) throws {
        self.regex = Array(regex)
        self.graph = Digraph(vertices: regex.count + 1)
        self.metacharacters = ["*", "+", "|", "(", ")"]
        try buildTransitionDigraph()
    }
    
    // O(regex.count).
    private func buildTransitionDigraph() throws {
        var stack = ArrayStack<Int>()
        
        for (index, currentChar) in regex.enumerated() {
            var lp = index
            
            if currentChar == "(" || currentChar == "|" {
                stack.push(index)
            }
            else if currentChar == ")" {
                var orIndices = [Int]()
                
                while let or = stack.pop() {
                    if regex[or] == "|" {
                        orIndices.append(or)
                    }
                    else if regex[or] == "(" {
                        lp = or
                        break
                    }
                }
                
                guard regex[lp] == "(" else {
                    throw NFAError.parenthesisMismatch
                }
                
                for or in orIndices {
                    graph.addEdge(v: lp, w: or + 1)
                    graph.addEdge(v: or, w: index)
                }
            }
            
            if index < regex.count - 1 && regex[index + 1] == "*" {
                graph.addEdge(v: lp, w: index + 1)
                graph.addEdge(v: index + 1, w: lp)
            }
            
            if index < regex.count - 1 && regex[index + 1] == "+" {
                graph.addEdge(v: index + 1, w: lp)
            }
            
            if ["(", "*", "+", ")"].contains(currentChar) {
                graph.addEdge(v: index, w: index + 1)
            }
        }
        
        if !stack.isEmpty() {
            throw NFAError.invalidRegularExpression
        }
    }
    
    // O(regex.count * text.count) worst case.
    public func recognizes(text: String) throws -> Bool {
        var dfs = DepthFirstSearch(graph: graph, source: 0)
        var pc = [Int]()
        
        for vertex in 0..<graph.vertexCount() {
            if dfs.hasPath(to: vertex) { pc.append(vertex) }
        }
        
        for char in text {
            if metacharacters.contains(char) {
                throw NFAError.textContainsMetacharacters(char: char)
            }
            
            var match = [Int]()
            for vertex in pc {
                if vertex == regex.count { continue }
                if regex[vertex] == char || regex[vertex] == "." {
                    match.append(vertex + 1)
                }
            }
            
            if match.isEmpty { continue }
            
            dfs = DepthFirstSearch(graph: graph, sources: match)
            pc = [Int]()
            for vertex in 0..<graph.vertexCount() {
                if dfs.hasPath(to: vertex) { pc.append(vertex) }
            }
            
            if pc.isEmpty { return false }
        }
        
        return pc.contains(regex.count)
    }
    
}

enum NFAError: Error, CustomStringConvertible {
    
    case invalidRegularExpression
    case parenthesisMismatch
    case textContainsMetacharacters(char: Character)
    
    public var description: String {
        switch self {
        case .invalidRegularExpression:
            return "The regular expression is not valid."
            
        case .parenthesisMismatch:
            return "The regular expression contains mismatched paranthesis."
            
        case .textContainsMetacharacters(let char):
            return "The text contains the metacharacter '\(char)'."
        }
    }
    
}
