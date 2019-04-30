//
//  Flower.swift
//  MoireCreator
//
//  Created by yuji shimada on 2018/04/04.
//  Copyright © 2018年 yuji shimada. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Flower: BaseType {
  
  let lineA: Int = 0
  let lineB: Int = 1
  
  let pointNumber = 6
  
  var centerPoint: CGPoint!
  
  var length: CGFloat!
  
  var degrees: CGFloat = 0
  
  var outer = [CircumferencePoint]()
  var middle = [CircumferencePoint]()
  var inner = [CircumferencePoint]()
  
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
      outer.append(CircumferencePoint(point: CGPoint(), radius: length, degree: CGFloat(i*60)))
      middle.append(CircumferencePoint(point: CGPoint(), radius: length*4/5, degree: CGFloat(i*60+15)))
      inner.append(CircumferencePoint(point: CGPoint(), radius: length*3/5, degree: CGFloat(i*60+30)))
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
        centerPoint.x + circumferencePoint.radius * cos((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
      circumferencePoint.point.y =
        centerPoint.y - circumferencePoint.radius * sin((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
    }
    
    for circumferencePoint in middle {
      circumferencePoint.point.x =
        centerPoint.x + circumferencePoint.radius * cos((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
      circumferencePoint.point.y =
        centerPoint.y - circumferencePoint.radius * sin((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
    }
    
    for circumferencePoint in inner {
      circumferencePoint.point.x =
        centerPoint.x + circumferencePoint.radius * cos((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
      circumferencePoint.point.y =
        centerPoint.y - circumferencePoint.radius * sin((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
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
    
    for circumferencePoint in middle {
      circumferencePoint.point.x += dx
      circumferencePoint.point.y += dy
    }
    
    for circumferencePoint in inner {
      circumferencePoint.point.x += dx
      circumferencePoint.point.y += dy
    }
    
    setPath()
  }
  
  func checkOutOfRange(frameWidth :Int, whichLine :Int, centerX: CGFloat){
    centerPoint.x = centerX
    
    for circumferencePoint in outer {
      circumferencePoint.point.x =
        centerX + circumferencePoint.radius * cos((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
    }
    
    for circumferencePoint in middle {
      circumferencePoint.point.x =
        centerX + circumferencePoint.radius * cos((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
    }
    
    for circumferencePoint in inner {
      circumferencePoint.point.x =
        centerX + circumferencePoint.radius * cos((circumferencePoint.degree + degrees).adjustDegree.degreesToRadians)
    }
    
    setPath()
  }
  
  func setPath(){
    path.removeAllPoints()
    path.move(to: inner[pointNumber-1].point)
    for i in 0..<pointNumber {
      path.addCurve(
        to: inner[i].point,
        controlPoint1: outer[i].point,
        controlPoint2: middle[i].point)
    }
  }
  
  func setThick(thick: Int) {
    self.thick = thick
  }
}

