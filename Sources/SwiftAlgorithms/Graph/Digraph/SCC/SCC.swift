//
//  SCC.swift
//  Created by hg on 11/03/2022.
//

import Foundation

public protocol SCC {
    
    func isStronglyConnected(v: Int, w: Int) -> Bool
    func id(vertex: Int) -> Int
    func count() -> Int
    
}
