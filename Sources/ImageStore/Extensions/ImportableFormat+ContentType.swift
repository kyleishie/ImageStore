//
//  ImportableFormat+ContentType.swift
//  Swift 4.0
//  Created by Kyle Ishie, Kyle Ishie Development.
//


import Foundation
import SwiftGD

extension ImportableFormat {
    
    init?(contentType: String) {
        switch contentType {
        case "image/jpeg":
            self = .jpg
        case "image/png":
            self = .png
        case "image/gif":
            self = .gif
        default:
            return nil
        }
    }
    
}
