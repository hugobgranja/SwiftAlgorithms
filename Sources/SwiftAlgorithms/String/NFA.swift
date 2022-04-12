//
//  NFA.swift
//  Created by hg on 12/04/2022.
//

import Foundation

public class NFA {
    
    private let regex: String
    private let graph: Digraph
    private let metacharacters: [Character]
    
    public init(regex: String) throws {
        self.regex = regex
        self.graph = Digraph(vertices: regex.count + 1)
        self.metacharacters = ["*", "+", "|", "(", ")"]
        try buildTransitionDigraph()
    }
    
    // O(regex.count).
    private func buildTransitionDigraph() throws {
        let stack = ArrayStack<Int>()
        
        for index in 0..<regex.count {
            var lp = index
            let currentChar = regex[index]
            
            if currentChar == "(" || currentChar == "|" {
                stack.push(index)
            }
            else if currentChar == ")" {
                if let or = stack.pop() {
                    if regex[or] == "|" {
                        lp = stack.pop()!
                        graph.addEdge(v: lp, w: or + 1)
                        graph.addEdge(v: or, w: index)
                    }
                    else if regex[or] == "(" {
                        lp = or
                    }
                }
                else {
                    throw NFAError.parenthesisMismatch
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
        
        for index in 0..<text.count {
            if metacharacters.contains(text[index]) {
                throw NFAError.textContainsMetacharacters(char: text[index])
            }
            
            var match = [Int]()
            for vertex in pc {
                if vertex == regex.count { continue }
                if regex[vertex] == text[index] || regex[vertex] == "." {
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
