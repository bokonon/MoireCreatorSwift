//
//  Synapses.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/06/25.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Synapses: BaseTypes {
  
  var synapse = [Synapse]()
  
  var margin: CGFloat = 0
  
  init(whichLine: Int, frameWidth: Int, frameHeight: Int, number: Int){
    super.init(number: number)
    
    var centerX: CGFloat = 0
    var centerY: CGFloat = 0
    if whichLine == lineA {
      centerX = 0
      centerY = CGFloat(frameHeight) / 3
    } else if whichLine == lineB {
      centerX = CGFloat(frameWidth)
      centerY = CGFloat(frameHeight) * 2 / 3
    }
    margin = CGFloat(frameHeight / number)
    for i in 0..<self.number {
      synapse.append(Synapse(center: CGPoint(x: centerX, y: centerY),
                             left: CGPoint(x: centerX - margin * CGFloat(i), y: centerY),
                             top: CGPoint(x: centerX, y: centerY - margin * CGFloat(i)),
                             right: CGPoint(x: centerX + margin * CGFloat(i), y: centerY),
                             bottom: CGPoint(x: centerX, y: centerY + margin * CGFloat(i))))
    }
  }
  
  override func draw(){
    
    super.draw()
    
    for i in 0..<synapse.count {
      
      // change color of first and last lines for debug
      #if DEBUG
      if i == 0 {
        UIColor.red.setStroke()
      }
      else if i == synapse.count - 1 {
        UIColor.blue.setStroke()
      }
      else {
        UIColor.black.setStroke()
      }
      #endif
      
      synapse[i].path.lineWidth = CGFloat(thick)
      synapse[i].path.stroke()
    }
  }
  
  override func checkOutOfRange(frameWidth :Int, frameHeight :Int, whichLine :Int){
    if (synapse[number - 1].right.x < 0) {
      let startX = CGFloat(frameWidth) -  synapse[0].center.x + synapse[number - 1].right.x
      for i in 0..<synapse.count {
        synapse[i].center.x = startX
      }
    } else if (CGFloat(frameWidth) < synapse[number - 1].left.x) {
      let startX = synapse[0].center.x - synapse[number - 1].left.x
      for i in 0..<synapse.count {
        synapse[i].center.x = -startX
      }
    }
  }
  
  override func move(whichLine :Int){
    if (whichLine == lineA) {
      for i in 0..<synapse.count {
        synapse[i].autoMove(dx: dx, margin: margin * CGFloat(i))
      }
    } else if (whichLine == lineB) {
      for i in 0..<synapse.count {
        synapse[i].autoMove(dx: -dx, margin: margin * CGFloat(i))
      }
    }
  }
  
  override func touchMove(dx: CGFloat, dy: CGFloat){
    for i in 0..<synapse.count {
      synapse[i].touchMove(dx: dx, dy: dy, margin: margin * CGFloat(i));
    }
  }
  
  override func setThick(thick: Int) {
    self.thick = thick
    for i in 0..<synapse.count {
      synapse[i].setThick(thick: thick)
    }
  }
}

