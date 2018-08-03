//
//  Image.swift
//  Swift 4.0
//  Created by Kyle Ishie, Kyle Ishie Development.
//


import Foundation
import SwiftGD

extension Image {
    
    public enum Orientaion {
        case landscape
        case portrait
    }
    
    public var orientation : Orientaion {
        if size.width > size.height {
            return .landscape
        } else {
            return .portrait
        }
    }
    
    public enum ContentMode : String {
        case scaleToFit
        case aspectFill
        case aspectFit
        
        public init?(rawValue: String) {
            switch rawValue.lowercased() {
            case "fit", "aspectfit":
                self = .aspectFit
            case "fill", "aspectfill":
                self = .aspectFill
            case "scale", "scaletofit":
                self = .scaleToFit
            default:
                return nil
            }
        }
        
        public init(string: String?) {
            
            guard let string = string else {
                self = .aspectFill
                return
            }
            
            self = ContentMode.init(rawValue: string) ?? .aspectFill
        }
    }
    
    public func resizedFitting(dimension: Int, contentMode: ContentMode) -> Image? {
        switch contentMode {
        case .scaleToFit:
            return resizedTo(width: dimension, height: dimension)
        case .aspectFill:
            return aspectFilledTo(dimension: dimension)
        case .aspectFit:
            return aspectFittedTo(dimension: dimension)
        }
    }
    
    private func aspectFilledTo(dimension: Int) -> Image? {
        switch orientation {
        case .portrait:
            return resizedTo(width: dimension)
            
        case .landscape:
            return resizedTo(height: dimension)
        }
    }
    
    private func aspectFittedTo(dimension: Int) -> Image? {
        switch orientation {
        case .portrait:
            return resizedTo(height: dimension)
            
        case .landscape:
            return resizedTo(width: dimension)
        }
    }
    
    
    public enum SizeType : RawRepresentable {
        case small
        case medium
        case large
        case original
        case fitting(Int)
        case scale(Size)
        
        
        private enum SizeTypeStringConstants : String {
            case small
            case medium
            case large
            case original
        }
        
        public var dimension : Int {
            switch self {
            case .small:
                return 200
            case .medium:
                return 800
            case .large:
                return 1600
            case .original:
                return -1
            case .fitting(let dim):
                return dim
            case .scale(let size):
                return size.width < size.height ? size.width : size.height
            }
        }
        
        public init(string: String?) {
            
            guard let string = string else {
                self = .original
                return
            }
            
            self = SizeType.init(rawValue: string) ?? .original
        }
        
        public init?(rawValue: String) {
            if let sizeType = SizeTypeStringConstants(rawValue: rawValue) {
                switch sizeType {
                case .small:
                    self = .small
                case .medium:
                    self = .medium
                case .large:
                    self = .large
                case .original:
                    self = .original
                }
            } else if let size = Size(rawValue) {
                self = .scale(size)
                
            } else if let intValue = Int(rawValue) {
                self = .fitting(intValue)
                
            } else {
                return nil
            }
        }
        
        public var rawValue: String {
            switch self {
            case .small:
                return SizeTypeStringConstants.small.rawValue
            case .medium:
                return SizeTypeStringConstants.medium.rawValue
            case .large:
                return SizeTypeStringConstants.large.rawValue
            case .original:
                return SizeTypeStringConstants.original.rawValue
            case .fitting(let dim):
                return String(dim)
            case .scale(let size):
                return size.description
            }
        }
        
    }
    
    public func resizedTo(_ sizeType: SizeType, contentMode: ContentMode) -> Image? {
        switch sizeType {
        case .original:
            return self
            
        case .scale(let size):
            return resizedTo(width: size.width, height: size.height, applySmoothing: true)
            
        default:
            return resizedFitting(dimension: sizeType.dimension, contentMode: contentMode)
        }
    }
    
}
