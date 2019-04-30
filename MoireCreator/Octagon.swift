//
//  Plus.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/12.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

extension BinaryInteger {
  var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}

extension FloatingPoint {
  var degreesToRadians: Self { return self * .pi / 180 }
  var radiansToDegrees: Self { return self * 180 / .pi }
  var adjustDegree: Self {
    if self > 360 {
      return self - 360
    } else if (self < 0) {
      return 360 + self
    }
    return self
  }
}

class Octagon: BaseType {
  
  let lineA: Int = 0
  let lineB: Int = 1
  
  let pointNumber = 8
  
  var centerPoint: CGPoint!
  
  var length: CGFloat!
  
  var degrees: CGFloat = 0
  
  var outer = [CircumferencePoint]()
  
  var path: UIBezierPath!
  
  var thick: Int = 1
  
  override init(){
    super.init()
  }
  
  init(frameHeight: Int, centerPoint: CGPoint, whichLine: Int, length: CGFloat){
    super.init()
    
    path = UIBezierPath()
    
    self.centerPoint = centerPoint
    self.length = length
    
    // x2 = x1 + r × cosθ
    // y2 = y1 – r × sinθ
    
    for i in 0..<self.pointNumber {
      outer.append(CircumferencePoint(point: CGPoint(), radius: length, degree: CGFloat(i*45)))
    }
    
    setPath()
  }
  
  override func autoMove(dx :CGFloat){
    degrees += 2
    #if DEBUG
    print("degree : ", degrees)
    #endif
    if degrees >= 360 {
      degrees = degrees - 360
    }
    centerPoint.x += dx
    
    for circumferencePoint in outer {
      circumferencePoint.point.x =
        centerPoint.x + length * cos((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
      circumferencePoint.point.y =
        centerPoint.y - length * sin((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
    }
    
    setPath()
  }
  
  override func touchMove(dx :CGFloat, dy :CGFloat){
    centerPoint.x += dx
    centerPoint.y += dy
    
    for circumferencePoint in outer {
      circumferencePoint.point.x += dx
      circumferencePoint.point.y += dy
    }
    
    setPath()
  }
  
  func checkOutOfRange(frameWidth :Int, whichLine :Int, centerX: CGFloat){
    centerPoint.x = centerX
    
    for circumferencePoint in outer {
      circumferencePoint.point.x =
        centerX + length * cos((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
    }
    
    setPath()
  }
  
  func setPath(){
    path.removeAllPoints()
    for (index, circumferencePoint) in outer.enumerated() {
      if index == 0 {
        path.move(to: circumferencePoint.point)
      } else {
        path.addLine(to: circumferencePoint.point)
      }
    }
    path.addLine(to: outer[0].point)
  }
  
  func setThick(thick: Int) {
    self.thick = thick
  }
  
}

