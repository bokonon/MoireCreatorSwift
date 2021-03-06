//
//  BaseTypes.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/01.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class BaseTypes {
  
  let lineA: Int = 0
  let lineB: Int = 1
  
  let maxLines: Int = 50
  
  let autoSpeed: Float = 0.7
  
  var number: Int = 50
  
  var thick: Int = 1
  
  var slope: Int = 0
  
  var dx: CGFloat = 0.7
  
  var color: UIColor!
  
  init(number: Int) {
    self.number = number
  }
  
  func checkOutOfRange(frameWidth :Int) {
    
  }
  
  // for synapse
  func checkOutOfRange(frameWidth :Int, frameHeight :Int, whichLine :Int){
    
  }
  
  func move(whichLine :Int) {
    
  }
  
  func touchMove(dx: CGFloat, dy: CGFloat) {
    
  }
  
  // for original
  func touchMove(movePoint: CGPoint) {
    
  }
  
  func start(firstPoint: CGPoint) {
  }
  
  func end() {
  }
  
  func draw() {
    color.setStroke()
  }
  
  func setColor(color: UIColor) {
    self.color = color
  }
  
  func setThick(thick: Int) {
    self.thick = thick
  }
  
  //    func setSlope(slope: Int) {
  //        self.slope = slope
  //    }
  
}

