//
//  Constants.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/06/24.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

public protocol Enumerable {
    associatedtype Case = Self
}

public extension Enumerable where Case: Hashable {
    private static var iterator: AnyIterator<Case> {
        var n = 0
        return AnyIterator {
            defer { n += 1 }
            
            let next = withUnsafePointer(to: &n) {
                UnsafeRawPointer($0).assumingMemoryBound(to: Case.self).pointee
            }
            return next.hashValue == n ? next : nil
        }
    }
    
    public static func enumerate() -> EnumeratedSequence<AnySequence<Case>> {
        return AnySequence(self.iterator).enumerated()
    }
    
    public static var cases: [Case] {
        return Array(self.iterator)
    }
    
    public static var count: Int {
        return self.cases.count
    }
}

enum Type: Int, Enumerable {
    case LINE = 0
    case CIRCLE = 1
    case RECT = 2
    case HEART = 3
    case SYNAPSE = 4
    case ORIGINAL = 5
    case OCTAGON = 6
    
    var description: String {
        switch self {
        case .LINE:
            return "Line"
        case .CIRCLE:
            return "Circle"
        case .RECT:
            return "Rect"
        case .HEART:
            return "Heart"
        case .SYNAPSE:
            return "Synapse"
        case .ORIGINAL:
            return "Original"
        case .OCTAGON:
            return "Octagon"
        }
    }
}

struct ApiConstants {
    static let admobApiKey = "AdmobApiKey"
}

struct UserDefaultsConstants {
    static let type = "type"
    static let lineAColor = "lineAColor"
    static let lineBColor = "lineBColor"
    static let backgroundColor = "backgroundColor"
    static let lineANumber = "lineANumber"
    static let lineBNumber = "lineBNumber"
    static let lineAThick = "lineAThick"
    static let lineBThick = "lineBThick"
    static let lineASlope = "lineASlope"
    static let lineBSlope = "lineBSlope"
}
