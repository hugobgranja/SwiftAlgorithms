//
//  DirectedEdge.swift
//  Created by hg on 18/03/2022.
//

import Foundation

public class DirectedEdge {
    
    public let source: Int
    public let destination: Int
    public let weight: Double
    
    public init(from source: Int, to destination: Int, weight: Double) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }
    
}

extension DirectedEdge: Comparable {
    
    public static func == (lhs: DirectedEdge, rhs: DirectedEdge) -> Bool {
        return lhs.source == rhs.source &&
            lhs.destination == rhs.destination &&
            lhs.weight == rhs.weight
    }
    
    public static func < (lhs: DirectedEdge, rhs: DirectedEdge) -> Bool {
        return lhs.weight < rhs.weight
    }
    
}

extension DirectedEdge: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(source)
        hasher.combine(destination)
        hasher.combine(weight)
    }
    
}


extension DirectedEdge: CustomStringConvertible {
    
    public var description: String {
        return "\(source)-\(destination) \(weight)"
    }
    
}
