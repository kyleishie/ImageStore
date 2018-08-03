//
//  InMemoryImageStore.swift
//  Swift 4.0
//  Created by Kyle Ishie, Kyle Ishie Development.
//


import Foundation
import SwiftGD

class InMemoryImageStore : ImageStore {
    
    typealias Id = String
    
    private var _internalStorage = [Id : Image]()
    
    func store(_ image: Image, with id: String) throws {
        _internalStorage[id] = image
    }
    
    func retrieve(_ id: String) throws -> Image? {
        return _internalStorage[id]
    }
    
    func remove(_ id: String) throws {
        _internalStorage[id] = nil
    }
    
}

