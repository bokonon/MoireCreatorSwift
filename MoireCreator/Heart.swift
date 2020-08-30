//
//  Heart.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/06/20.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Heart: BaseType {
  
  private let point_count: Int = 3
  var width: CGFloat = 0
  var height: CGFloat = 0
  var centerTop: CGPoint!
  var leftTop = [CGPoint]()
  var leftBottom = [CGPoint]()
  var rightBottom = [CGPoint]()
  var rightTop = [CGPoint]()
  
  var path: UIBezierPath!
  
  var thick: Int = 1
  
  override init(){
    super.init()
  }
  
  init(centerX: CGFloat, centerY: CGFloat, width: CGFloat, height: CGFloat) {
    super.init()
    self.width = width
    self.height = height
    
    centerTop = CGPoint()
    for _ in 0..<point_count {
      leftTop.append(CGPoint())
      leftBottom.append(CGPoint())
      rightBottom.append(CGPoint())
      rightTop.append(CGPoint())
    }
    
    self.initPoint(centerX: centerX, centerY: centerY, width: width, height: height)
    
    path = UIBezierPath()
    self.setPath()
  }
  
  override func autoMove(dx :CGFloat){
    centerTop.x += dx
    
    for i in 0..<self.leftTop.count {
      leftTop[i].x += dx
    }
    for i in 0..<self.leftBottom.count {
      leftBottom[i].x += dx
    }
    for i in 0..<self.rightBottom.count {
      rightBottom[i].x += dx
    }
    for i in 0..<self.rightTop.count {
      rightTop[i].x += dx
    }
    
    setPath()
  }
  
  override func touchMove(dx :CGFloat, dy :CGFloat){
    centerTop.x += dx
    centerTop.y += dy
    
    for i in 0..<self.leftTop.count {
      leftTop[i].x += dx
      leftTop[i].y += dy
    }
    for i in 0..<self.leftBottom.count {
      leftBottom[i].x += dx
      leftBottom[i].y += dy
    }
    for i in 0..<self.rightBottom.count {
      rightBottom[i].x += dx
      rightBottom[i].y += dy
    }
    for i in 0..<self.rightTop.count {
      rightTop[i].x += dx
      rightTop[i].y += dy
    }
    
    setPath()
  }
  
  func initPoint(centerX: CGFloat, centerY: CGFloat, width: CGFloat, height: CGFloat) {
    centerTop.x = centerX
    centerTop.y = centerY - (height / 2 - height / 5)
    
    leftTop[0].x = centerX - (width / 2 - 5 * width / 14)
    leftTop[0].y = centerY - height / 2
    leftTop[1].x = centerX - width / 2
    leftTop[1].y = centerY - (height / 2 - height / 15)
    leftTop[2].x = centerX - (width / 2 - width / 28)
    leftTop[2].y = centerY - (height / 2 - 2 * height / 5)
    
    leftBottom[0].x = centerX - (width / 2 - width / 14)
    leftBottom[0].y = centerY + (2 * height / 3 - height / 2)
    leftBottom[1].x = centerX - (width / 2 - 3 * width / 7)
    leftBottom[1].y = centerY + (5 * height / 6 - height / 2)
    leftBottom[2].x = centerX
    leftBottom[2].y = centerY + height / 2
    
    rightBottom[0].x = centerX + (4 * width / 7 - width / 2)
    rightBottom[0].y = centerY + (5 * height / 6 - height / 2)
    rightBottom[1].x = centerX + (13 * width / 14 - width / 2)
    rightBottom[1].y = centerY + (2 * height / 3 - height / 2)
    rightBottom[2].x = centerX + (27 * width / 28 - width / 2)
    rightBottom[2].y = centerY - (height / 2 - 2 * height / 5)
    
    rightTop[0].x = centerX + width / 2
    rightTop[0].y = centerY - (height / 2 - height / 15)
    rightTop[1].x = centerX + (9 * width / 14 - width / 2)
    rightTop[1].y = centerY - height / 2
    rightTop[2].x = centerX
    rightTop[2].y = centerY - (height / 2 - height / 5)
  }
  
  func checkOutOfRange(centerX: CGFloat, centerY: CGFloat){
    initPoint(centerX: centerX, centerY: centerY, width: width, height: height)
    setPath()
  }
  
  func setPath(){
    path.removeAllPoints()
    
    // center top
    path.move(to: centerTop);
    
    // left top
    path.addCurve(to: leftTop[2], controlPoint1: leftTop[0], controlPoint2: leftTop[1]);
    
    // left bottom
    path.addCurve(to: leftBottom[2], controlPoint1: leftBottom[0], controlPoint2: leftBottom[1]);
    
    // right bottom
    path.addCurve(to: rightBottom[2], controlPoint1: rightBottom[0], controlPoint2: rightBottom[1]);
    
    // right top
    path.addCurve(to: rightTop[2], controlPoint1: rightTop[0], controlPoint2: rightTop[1]);
  }
  
  func setThick(thick: Int) {
    self.thick = thick
  }
  
}

