//
//  FlowEdge.swift
//  Created by hg on 26/03/2022.
//

import Foundation

public class FlowEdge {
    
    public let source: Int
    public let destination: Int
    public let capacity: Decimal
    public var flow: Decimal
    
    public init(from source: Int, to destination: Int, capacity: Decimal) {
        self.source = source
        self.destination = destination
        self.capacity = capacity
        self.flow = 0
    }
    
    public func other(vertex: Int) -> Int? {
        if vertex == source { return destination }
        if vertex == destination { return source }
        return nil
    }
    
    public func residualCapacity(to vertex: Int) -> Decimal? {
        if vertex == source { return flow }
        if vertex == destination { return capacity - flow }
        return nil
    }
    
    public func addResidualFlow(to vertex: Int, delta: Decimal) {
        if vertex == source { flow -= delta }
        else if vertex == destination { flow += delta }
    }
    
}

extension FlowEdge: Equatable {
    
    public static func == (lhs: FlowEdge, rhs: FlowEdge) -> Bool {
        return lhs.source == rhs.source &&
            lhs.destination == rhs.destination &&
            lhs.capacity == rhs.capacity &&
            lhs.flow == rhs.flow
    }
    
}

extension FlowEdge: CustomStringConvertible {
    
    public var description: String {
        return "\(source)-\(destination) \(capacity) \(flow)"
    }
    
}
