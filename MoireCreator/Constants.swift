//
//  Constants.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/06/24.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

enum Type: Int, CaseIterable {
  case LINE = 0
  case CIRCLE = 1
  case RECT = 2
  case HEART = 3
  case SYNAPSE = 4
  case ORIGINAL = 5
  case OCTAGON = 6
  case FLOWER = 7
  
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
    case .FLOWER:
      return "Flower"
    }
  }
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

