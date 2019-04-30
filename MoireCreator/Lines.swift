//
//  Lines.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/01.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class Lines: BaseTypes {
  
  var line = [Line]()
  
  init(whichLine: Int, frameWidth: Int, frameHeight: Int, number: Int, slope: Int){
    super.init(number: number)
    self.slope = slope
    for i in 0..<self.number {
      if whichLine == lineA {
        line.append(Line(frameHeight: frameHeight, slope: slope, basePoint: Int(Float(frameWidth + slope) / Float(number) * Float(i)), arg: 0))
      }
      else {
        line.append(Line(frameHeight: frameHeight, slope: slope, basePoint: Int(Float(frameWidth + slope) / Float(number) * Float(i)), arg: slope))
      }
    }
  }
  
  override func draw(){
    
    super.draw()
    
    for i in 0..<line.count {
      
      // change color of first and last lines for debug
      #if DEBUG
      if i == 0 {
        UIColor.red.setStroke()
      }
      else if i == line.count - 1 {
        UIColor.blue.setStroke()
      }
      else {
        UIColor.black.setStroke()
      }
      #endif
      
      line[i].path.lineWidth = CGFloat(thick)
      line[i].path.stroke()
    }
  }
  
  override func checkOutOfRange(frameWidth :Int){
    for i in 0..<line.count {
      line[i].checkOutOfRange(frameWidth: frameWidth, slope: slope)
    }
  }
  
  override func move(whichLine :Int){
    if whichLine == lineA {
      for i in 0..<line.count {
        line[i].autoMove(dx: dx);
      }
      
    }
    else if whichLine == lineB {
      for j in 0..<line.count {
        line[j].autoMove(dx: -dx);
      }
    }
  }
  
  override func touchMove(dx: CGFloat, dy: CGFloat){
    for i in 0..<line.count {
      line[i].touchMove(dx: dx, dy: dy);
    }
  }
  
  //    override func setNumber(number: Int) {
  //        super.setNumber(number)
  //
  //    }
}

