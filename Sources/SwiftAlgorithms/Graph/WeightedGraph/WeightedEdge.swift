//
//  WeightedEdge.swift
//  Created by hg on 13/03/2022.
//

import Foundation

public class WeightedEdge {
    
    public let v: Int
    public let w: Int
    public let weight: Double
    
    public init(v: Int, w: Int, weight: Double) {
        self.v = v
        self.w = w
        self.weight = weight
    }
    
    public func other(vertex: Int) -> Int? {
        if vertex == v { return w }
        if vertex == w { return v }
        return nil
    }
    
}

extension WeightedEdge: Comparable {
    
    public static func == (lhs: WeightedEdge, rhs: WeightedEdge) -> Bool {
        return lhs.v == rhs.v && lhs.w == rhs.w && lhs.weight == rhs.weight
    }
    
    public static func < (lhs: WeightedEdge, rhs: WeightedEdge) -> Bool {
        return lhs.weight < rhs.weight
    }
    
}

extension WeightedEdge: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(v)
        hasher.combine(w)
        hasher.combine(weight)
    }
    
}

extension WeightedEdge: CustomStringConvertible {
    
    public var description: String {
        return "\(v)-\(w) \(weight)"
    }
    
}
