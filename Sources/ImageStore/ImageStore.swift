import Foundation
import SwiftGD

public protocol ImageStore {
    
    associatedtype Id : CustomStringConvertible
    
    func store(_ image: Image, with id: Id) throws
    
    func retrieve(_ id: Id) throws -> Image?
    
    func remove(_ id: Id) throws
    
}

extension ImageStore {
    
    public func remove(_ id: Id) throws {}
    
}

