//
//  UIMoireView.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/01.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import UIKit

class UIMoireView: UIView {
  
  let maxLines: Int = 50
  let maxThick: Int = 20
  let maxSlope: Int = 150
  
  var moireType: Type!
  
  let lineA: Int = 0
  let lineB: Int = 1
  
  var typesA: BaseTypes!
  var typesB: BaseTypes!
  
  var frameWidth: Int!
  var frameHeight: Int!
  
  var isPause: Bool = false
  
  var isTouching: Bool = false
  var isTouchingLine: Int = 0
  
  // init from story board
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  // init from code
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
    
    guard let moireType = moireType else {
      return
    }
    
    switch moireType {
    case .LINE:
      typesA.checkOutOfRange(frameWidth: frameWidth)
      typesB.checkOutOfRange(frameWidth: frameWidth)
      
      if(!isPause){
        if(isTouchingLine == lineA && isTouching) {
          // do nothing
        }
        else {
          typesA.move(whichLine: lineA)
        }
        if(isTouchingLine == lineB && isTouching) {
          // do nothing
        }
        else {
          typesB.move(whichLine: lineB)
        }
      }
      typesA.draw()
      typesB.draw()
    case .CIRCLE:
      typesA.checkOutOfRange(frameWidth: frameWidth)
      typesB.checkOutOfRange(frameWidth: frameWidth)
      
      if(!isPause){
        if(isTouchingLine == lineB) {
          typesA.move(whichLine: lineA)
        }
        else if(isTouchingLine == lineA && !isTouching){
          typesA.move(whichLine: lineA)
        }
        if(isTouchingLine == lineA) {
          typesB.move(whichLine: lineB)
        }
        else if(isTouchingLine == lineB && !isTouching){
          typesB.move(whichLine: lineB)
        }
      }
      typesA.draw()
      typesB.draw()
    case .RECT:
      fallthrough
    case .HEART:
      fallthrough
    case .SYNAPSE:
      fallthrough
    case .OCTAGON:
      fallthrough
    case .FLOWER:
      typesA.checkOutOfRange(frameWidth: frameWidth, frameHeight: frameHeight, whichLine: lineA)
      typesB.checkOutOfRange(frameWidth: frameWidth, frameHeight: frameHeight, whichLine: lineB)
      
      if(!isPause){
        if(isTouchingLine == lineA && isTouching) {
          // do nothing
        }
        else {
          typesA.move(whichLine: lineA)
        }
        if(isTouchingLine == lineB && isTouching) {
          // do nothing
        }
        else {
          typesB.move(whichLine: lineB)
        }
      }
      typesA.draw()
      typesB.draw()
      
    case .ORIGINAL:
      if(!isPause){
        if(isTouchingLine == lineA && isTouching) {
          // do nothing
        }
        else {
          if(!isTouching) {
            typesA.checkOutOfRange(frameWidth: frameWidth)
          }
          typesA.move(whichLine: lineA)
        }
        if(isTouchingLine == lineB && isTouching) {
          // do nothing
        }
        else {
          if(!isTouching) {
            typesB.checkOutOfRange(frameWidth: frameWidth)
          }
          typesB.move(whichLine: lineB)
        }
      }
      typesA.draw()
      typesB.draw()
      
    default:
      print("default")
    }
  }
  
  func updateView(type: Type, backgroundColor: UIColor,
                  lineAColor: UIColor, lineBColor: UIColor,
                  lineANumber: Int, lineBNumber: Int,
                  lineAThick: Int, lineBThick: Int,
                  lineASlope: Int, lineBSlope: Int) {
    
    frameWidth = Int(self.frame.width)
    frameHeight = Int(self.frame.height)
    
    #if DEBUG
    print("frameWidth : ", frameWidth)
    print("frameHeight : ", frameHeight)
    #endif
    
    self.moireType = type
    
    #if DEBUG
    print("moireType : ", moireType)
    #endif
    
    self.backgroundColor = backgroundColor
    
    guard let moireType = moireType else {
      return
    }
    
    switch moireType {
    case .LINE:
      typesA = Lines(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber, slope: lineASlope)
      typesB = Lines(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber, slope: lineBSlope)
    case .CIRCLE:
      typesA = Circles(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
      typesB = Circles(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber)
    case .RECT:
      typesA = Rectangles(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber, slope: lineASlope)
      typesB = Rectangles(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber, slope: lineBSlope)
    case .HEART:
      typesA = Hearts(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
      typesB = Hearts(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber)
    case .SYNAPSE:
      typesA = Synapses(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
      typesB = Synapses(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber)
    case .ORIGINAL:
      typesA = Originals(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
      typesB = Originals(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
    case .OCTAGON:
      typesA = Octagons(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
      typesB = Octagons(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber)
    case .FLOWER:
      typesA = Flowers(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
      typesB = Flowers(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber)
    default:
      #if DEBUG
      print("IllegalArgument on update")
      #endif
    }
    
    typesA.setColor(color: lineAColor)
    typesA.setThick(thick: lineAThick)
    typesB.setColor(color: lineBColor)
    typesB.setThick(thick: lineBThick)
    
  }
  
  func touchMove(_ whichLine: Int, dx: CGFloat, dy: CGFloat) {
    
    guard let moireType = moireType else {
      return
    }
    switch moireType {
    case .LINE:
      fallthrough
    case .CIRCLE:
      fallthrough
    case .RECT:
      fallthrough
    case .HEART:
      fallthrough
    case .SYNAPSE:
      fallthrough
    case .OCTAGON:
      fallthrough
    case .FLOWER:
      if(whichLine == lineA) {
        typesA.touchMove(dx: dx, dy: dy)
        //                linesA.checkOutOfRange(frameWidth)
        //                linesA.draw()
      }
      else {
        typesB.touchMove(dx: dx, dy: dy)
        //                linesB.checkOutOfRange(frameWidth)
        //                linesB.draw()
      }
    case .ORIGINAL:
      // do nothing
      #if DEBUG
      print("default")
      #endif
    default:
      #if DEBUG
      print("default")
      #endif
    }
  }
  
  func touchOriginalMove(_ whichLine: Int, movePoint: CGPoint) {
    
    if(whichLine == lineA) {
      typesA.touchMove(movePoint: movePoint)
      //            originalsA.checkOutOfRange(frameWidth)
      typesA.draw()
    }
    else {
      typesB.touchMove(movePoint: movePoint)
      //            originalsB.checkOutOfRange(frameWidth)
      typesB.draw()
    }
  }
  
  func setOnpause(_ isPause: Bool) {
    self.isPause = isPause
  }
  
  func isOnPause() -> Bool{
    return isPause
  }
  
  func getCapture() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
    drawHierarchy(in: self.bounds, afterScreenUpdates: true)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
  
  func setTouchingMode(_ touchingLine: Int, isTouching: Bool, firstPoint: CGPoint) {
    self.isTouchingLine = touchingLine
    self.isTouching = isTouching
    
    guard let moireType = moireType else {
      return
    }
    
    switch moireType {
    case .ORIGINAL:
      // touch down
      if(isTouching) {
        if(touchingLine == lineA) {
          typesA.start(firstPoint: firstPoint)
        }
        else {
          typesB.start(firstPoint: firstPoint)
        }
      }
        // touch up
      else {
        if(touchingLine == lineA) {
          typesA.end()
        }
        else {
          typesB.end()
        }
      }
    default:
      #if DEBUG
      print("default")
      #endif
    }
  }
  
}

