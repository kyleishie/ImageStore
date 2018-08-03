//
//  Size.swift
//  Swift 4.0
//  Created by Kyle Ishie, Kyle Ishie Development.
//


import Foundation
import SwiftGD

extension Size : CustomStringConvertible, LosslessStringConvertible {
    
    public init?(_ description: String) {
        let components = description.components(separatedBy: ",")
        
        guard components.count == 2 else {
            return nil
        }
        
        guard let width = Int(components.first!), let height = Int(components.last!) else {
            return nil
        }
        
        self.init(width: width, height: height)
    }
    
    public var description: String {
        return "\(width),\(height)"
    }
    
}
