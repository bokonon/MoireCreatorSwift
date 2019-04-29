//
//  Rectangle.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/21.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Rectangle: BaseType {
  
  let lineA: Int = 0
  let lineB: Int = 1
  
  var leftTopPoint: CGPoint!
  
  var rightTopPoint: CGPoint!
  
  var rightBottomPoint: CGPoint!
  
  var leftBottomPoint: CGPoint!
  
  var length: CGFloat!
  
  var path: UIBezierPath!
  
  var thick: Int = 1
  
  override init(){
    super.init()
  }
  
  init(frameHeight: Int, slope: Int, centerPoint: CGPoint, whichLine: Int, length: CGFloat){
    
    path = UIBezierPath()
    
    self.length = length
    
    if(whichLine == lineA) {
      let commonTopY = centerPoint.y - CGFloat(length)/2
      leftTopPoint = CGPoint(x: centerPoint.x - CGFloat(length)/2 , y: commonTopY)
      rightTopPoint = CGPoint(x: centerPoint.x + CGFloat(slope) + CGFloat(length)/2, y: commonTopY)
      
      let commonBottomY = centerPoint.y + CGFloat(length)/2
      rightBottomPoint = CGPoint(x: centerPoint.x + CGFloat(length)/2, y: commonBottomY)
      leftBottomPoint = CGPoint(x: centerPoint.x - CGFloat(slope) - CGFloat(length)/2, y: commonBottomY)
    }
    else {
      let commonTopY = centerPoint.y - CGFloat(length)/2
      leftTopPoint = CGPoint(x: centerPoint.x - CGFloat(length)/2 - CGFloat(slope), y: commonTopY)
      rightTopPoint = CGPoint(x: centerPoint.x + CGFloat(length)/2, y: commonTopY)
      
      let commonBottomY = centerPoint.y + CGFloat(length)/2
      rightBottomPoint = CGPoint(x: centerPoint.x + CGFloat(slope) + CGFloat(length)/2, y: commonBottomY)
      leftBottomPoint = CGPoint(x: centerPoint.x - CGFloat(length)/2, y: commonBottomY)
    }
    
    path.removeAllPoints()
    path.move(to: leftTopPoint)
    path.addLine(to: rightTopPoint)
    path.addLine(to: rightBottomPoint)
    path.addLine(to: leftBottomPoint)
    // for draw
    path.addLine(to: CGPoint(x: leftTopPoint.x, y: leftTopPoint.y - CGFloat(thick)/2))
  }
  
  override func autoMove(dx :CGFloat){
    leftTopPoint.x += dx
    rightTopPoint.x += dx
    rightBottomPoint.x += dx
    leftBottomPoint.x += dx
    setPath()
  }
  
  override func touchMove(dx :CGFloat, dy :CGFloat){
    leftTopPoint.x += dx
    rightTopPoint.x += dx
    rightBottomPoint.x += dx
    leftBottomPoint.x += dx
    leftTopPoint.y += dy
    rightTopPoint.y += dy
    rightBottomPoint.y += dy
    leftBottomPoint.y += dy
    setPath()
  }
  
  func checkOutOfRange(frameWidth :Int, slope :Int, whichLine :Int, centerX: CGFloat){
    if(whichLine == lineA) {
      leftTopPoint = CGPoint(x: centerX - CGFloat(length)/2 , y: leftTopPoint.y)
      rightTopPoint = CGPoint(x: centerX + CGFloat(slope) + CGFloat(length)/2, y: rightTopPoint.y)
      rightBottomPoint = CGPoint(x: centerX + CGFloat(length)/2, y: rightBottomPoint.y)
      leftBottomPoint = CGPoint(x: centerX - CGFloat(slope) - CGFloat(length)/2, y: leftBottomPoint.y)
    }
    else {
      leftTopPoint = CGPoint(x: centerX - CGFloat(slope) - CGFloat(length)/2 , y: leftTopPoint.y)
      rightTopPoint = CGPoint(x: centerX + CGFloat(length)/2, y: rightTopPoint.y)
      rightBottomPoint = CGPoint(x: centerX + CGFloat(slope) + CGFloat(length)/2, y: rightBottomPoint.y)
      leftBottomPoint = CGPoint(x: centerX - CGFloat(length)/2, y: leftBottomPoint.y)
    }
    setPath()
  }
  
  func setPath(){
    path.removeAllPoints()
    path.move(to: leftTopPoint)
    path.addLine(to: rightTopPoint)
    path.addLine(to: rightBottomPoint)
    path.addLine(to: leftBottomPoint)
    // for draw
    path.addLine(to: CGPoint(x: leftTopPoint.x, y: leftTopPoint.y - CGFloat(thick)/2))
  }
  
  func setThick(thick: Int) {
    self.thick = thick
  }
  
}

