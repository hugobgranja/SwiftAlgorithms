//
//  CLRSNode.swift
//  Created by hg on 13/01/2021.
//

import Foundation

public enum CLRSNode<Key,Value> where Key: Comparable {
    
    case some(CLRSSomeNode<Key,Value>)
    case none(CLRSNilNode<Key,Value>)
    
    public init(
        key: Key,
        value: Value,
        color: RBTNodeColor,
        parent: CLRSNode<Key,Value>,
        left: CLRSNode<Key,Value>,
        right: CLRSNode<Key,Value>
    ) {
        self = .some(
            CLRSSomeNode(
                key: key,
                value: value,
                color: color,
                parent: parent,
                left: left,
                right: right
            )
        )
    }
    
    public var key: Key? {
        get {
            switch self {
            case .some(let x): return x.key
            case .none: return nil
            }
        }
        set {
            switch self {
            case .some(let x): if let newValue = newValue { x.key = newValue }
            case .none: break
            }
        }
    }
    
    public var value: Value? {
        get {
            switch self {
            case .some(let x): return x.value
            case .none: return nil
            }
        }
        set {
            switch self {
            case .some(let x): if let newValue = newValue { x.value = newValue }
            case .none: break
            }
        }
    }
    
    public var parent: CLRSNode<Key,Value> {
        get {
            switch self {
            case .some(let x): return x.parent
            case .none(let y): return y.parent ?? self
            }
        }
        set {
            switch self {
            case .some(let x): x.parent = newValue
            case .none(let y): y.parent = newValue
            }
        }
    }
    
    public var left: CLRSNode<Key,Value> {
        get {
            switch self {
            case .some(let x): return x.left
            case .none: return self
            }
        }
        set {
            switch self {
            case .some(let x): x.left = newValue
            case .none: break
            }
        }
    }
    
    public var right: CLRSNode<Key,Value> {
        get {
            switch self {
            case .some(let x): return x.right
            case .none: return self
            }
        }
        set {
            switch self {
            case .some(let x): x.right = newValue
            case .none: break
            }
        }
    }
    
    public var color: RBTNodeColor {
        get {
            switch self {
            case .some(let x): return x.color
            case .none: return .black
            }
        }
        set {
            switch self {
            case .some(let x): x.color = newValue
            case .none: break
            }
        }
    }
    
    public var count: Int {
        get {
            switch self {
            case .some(let x): return x.count
            case .none: return 0
            }
        }
        set {
            switch self {
            case .some(let x): x.count = newValue
            case .none: break
            }
        }
    }
    
}

extension CLRSNode: Equatable {
    
    public static func == (lhs: CLRSNode<Key, Value>, rhs: CLRSNode<Key, Value>) -> Bool {
        switch lhs {
        case .some(let lhsNode):
            switch rhs {
            case .some(let rhsNode): return lhsNode == rhsNode
            case .none: return false
            }
            
        case .none:
            switch rhs {
            case .some: return false
            case .none: return true
            }
        }
    }
    
}

public class CLRSSomeNode<Key, Value> where Key: Comparable {
    
    public var key: Key
    public var value: Value
    public var parent: CLRSNode<Key,Value>
    public var left: CLRSNode<Key,Value>
    public var right: CLRSNode<Key,Value>
    public var count: Int
    public var color: RBTNodeColor
    
    public init(
        key: Key,
        value: Value,
        color: RBTNodeColor,
        parent: CLRSNode<Key,Value>,
        left: CLRSNode<Key,Value>,
        right: CLRSNode<Key,Value>
    ) {
        self.key = key
        self.value = value
        self.parent = parent
        self.left = left
        self.right = right
        self.count = 1
        self.color = color
    }
    
}

extension CLRSSomeNode: Equatable {
    
    public static func == (lhs: CLRSSomeNode<Key, Value>, rhs: CLRSSomeNode<Key, Value>) -> Bool {
        return lhs.key == rhs.key
    }
    
}

public class CLRSNilNode<Key,Value> where Key: Comparable {
    
    public var parent: CLRSNode<Key,Value>?
    
}
