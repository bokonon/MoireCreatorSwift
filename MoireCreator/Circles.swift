//
//  Circles.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/18.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class Circles: BaseTypes {
  
  var circle = [Circle]()
  
  init(whichLine: Int, frameWidth: Int, frameHeight: Int, number: Int){
    super.init(number: number)
    let maxRadius = CGFloat(frameHeight)/3.0
    for i in 0..<self.number {
      if whichLine == lineA {
        circle.append(Circle(point: CGPoint(x: 0,y: CGFloat(frameHeight)/CGFloat(3)), radius: maxRadius/CGFloat(number)*CGFloat(i)))
      }
      else {
        circle.append(Circle(point: CGPoint(x: CGFloat(frameWidth),y: CGFloat(frameHeight)*CGFloat(2)/CGFloat(3)), radius: maxRadius/CGFloat(number)*CGFloat(i)))
      }
    }
  }
  
  override func draw(){
    
    super.draw()
    
    for i in 0..<circle.count {
      
      // change color of first and last lines for debug
      #if DEBUG
      if i == 0 {
        UIColor.red.setStroke()
      }
      else if i == circle.count - 1 {
        UIColor.blue.setStroke()
      }
      else {
        UIColor.black.setStroke()
      }
      #endif
      
      circle[i].path.lineWidth = CGFloat(thick)
      circle[i].path.stroke()
    }
  }
  
  override func checkOutOfRange(frameWidth :Int){
    if CGFloat(frameWidth) < circle[number-1].centerPoint.x - circle[number-1].radius {
      for i in 0..<circle.count {
        circle[i].checkOutOfRange(frameWidth: frameWidth)
      }
    }
    else if circle[number-1].centerPoint.x + circle[number-1].radius < 0 {
      for i in 0..<circle.count {
        circle[i].checkOutOfRange(frameWidth: frameWidth)
      }
    }
  }
  
  override func move(whichLine :Int){
    if whichLine == lineA {
      for i in 0..<circle.count {
        circle[i].autoMove(dx: dx);
      }
      
    }
    else if whichLine == lineB {
      for j in 0..<circle.count {
        circle[j].autoMove(dx: -dx);
      }
    }
  }
  
  override func touchMove(dx: CGFloat, dy: CGFloat){
    for i in 0..<circle.count {
      circle[i].touchMove(dx: dx, dy: dy);
    }
  }
}

