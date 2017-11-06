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
    
    var moireType: Int!
    
    let lineA: Int = 0
    let lineB: Int = 1
    
    var linesA: Lines!
    var linesB: Lines!
    
    var circlesA: Circles!
    var circlesB: Circles!
    
    var rectanglesA: Rectangles!
    var rectanglesB: Rectangles!
    
    var heartsA: Hearts!
    var heartsB: Hearts!
    
    var synapsesA: Synapses!
    var synapsesB: Synapses!
    
    var originalsA: Originals!
    var originalsB: Originals!
    
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
        
        if moireType == nil {
            return
        }
        
        switch moireType {
        case Constants.typeLine:
            linesA.checkOutOfRange(frameWidth: frameWidth)
            linesB.checkOutOfRange(frameWidth: frameWidth)
            
            if(!isPause){
                if(isTouchingLine == lineA && isTouching) {
                    // do nothing
                }
                else {
                    linesA.move(whichLine: lineA)
                }
                if(isTouchingLine == lineB && isTouching) {
                    // do nothing
                }
                else {
                    linesB.move(whichLine: lineB)
                }
            }
            linesA.draw()
            linesB.draw()
        case Constants.typeCircle:
            circlesA.checkOutOfRange(frameWidth: frameWidth)
            circlesB.checkOutOfRange(frameWidth: frameWidth)
            
            if(!isPause){
                if(isTouchingLine == lineB) {
                    circlesA.move(whichLine: lineA)
                }
                else if(isTouchingLine == lineA && !isTouching){
                    circlesA.move(whichLine: lineA)
                }
                if(isTouchingLine == lineA) {
                    circlesB.move(whichLine: lineB)
                }
                else if(isTouchingLine == lineB && !isTouching){
                    circlesB.move(whichLine: lineB)
                }
            }
            circlesA.draw()
            circlesB.draw()
        case Constants.typeRect:
            rectanglesA.checkOutOfRange(frameWidth: frameWidth, frameHeight: frameHeight, whichLine: lineA)
            rectanglesB.checkOutOfRange(frameWidth: frameWidth, frameHeight: frameHeight, whichLine: lineB)
            
            if(!isPause){
                if(isTouchingLine == lineA && isTouching) {
                    // do nothing
                }
                else {
                    rectanglesA.move(whichLine: lineA)
                }
                if(isTouchingLine == lineB && isTouching) {
                    // do nothing
                }
                else {
                    rectanglesB.move(whichLine: lineB)
                }
            }
            rectanglesA.draw()
            rectanglesB.draw()
        case Constants.typeHeart:
            heartsA.checkOutOfRange(frameWidth: frameWidth, frameHeight: frameHeight, whichLine: lineA)
            heartsB.checkOutOfRange(frameWidth: frameWidth, frameHeight: frameHeight, whichLine: lineB)
            
            if(!isPause){
                if(isTouchingLine == lineA && isTouching) {
                    // do nothing
                }
                else {
                    heartsA.move(whichLine: lineA)
                }
                if(isTouchingLine == lineB && isTouching) {
                    // do nothing
                }
                else {
                    heartsB.move(whichLine: lineB)
                }
            }
            heartsA.draw()
            heartsB.draw()
        case Constants.typeSynapse:
            synapsesA.checkOutOfRange(frameWidth: frameWidth, frameHeight: frameHeight, whichLine: lineA)
            synapsesB.checkOutOfRange(frameWidth: frameWidth, frameHeight: frameHeight, whichLine: lineB)
            
            if(!isPause){
                if(isTouchingLine == lineA && isTouching) {
                    // do nothing
                }
                else {
                    synapsesA.move(whichLine: lineA)
                }
                if(isTouchingLine == lineB && isTouching) {
                    // do nothing
                }
                else {
                    synapsesB.move(whichLine: lineB)
                }
            }
            synapsesA.draw()
            synapsesB.draw()
        case Constants.typeOriginal:
            if(!isPause){
                if(isTouchingLine == lineA && isTouching) {
                    // do nothing
                }
                else {
                    if(!isTouching) {
                        originalsA.checkOutOfRange(frameWidth: frameWidth)
                    }
                    originalsA.move(whichLine: lineA)
                }
                if(isTouchingLine == lineB && isTouching) {
                    // do nothing
                }
                else {
                    if(!isTouching) {
                        originalsB.checkOutOfRange(frameWidth: frameWidth)
                    }
                    originalsB.move(whichLine: lineB)
                }
            }
            originalsA.draw()
            originalsB.draw()
        default:
            print("default")
        }
    }
        
    func updateView(type: Int, backgroundColor: UIColor,
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
        
        // set type
        self.moireType = type
        
        #if DEBUG
        print("moireType : ", moireType)
        #endif
        
        self.backgroundColor = backgroundColor
        
        switch moireType {
        case Constants.typeLine:
            linesA = Lines(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber, slope: lineASlope)
            linesA.setColor(color: lineAColor)
            linesA.setThick(thick: lineAThick)
            linesB = Lines(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber, slope: lineBSlope)
            linesB.setColor(color: lineBColor)
            linesB.setThick(thick: lineBThick)
        case Constants.typeCircle:
            circlesA = Circles(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
            circlesA.setColor(color: lineAColor)
            circlesA.setThick(thick: lineAThick)
            circlesB = Circles(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber)
            circlesB.setColor(color: lineBColor)
            circlesB.setThick(thick: lineBThick)
        case Constants.typeRect:
            rectanglesA = Rectangles(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber, slope: lineASlope)
            rectanglesA.setColor(color: lineAColor)
            rectanglesA.setThick(thick: lineAThick)
            rectanglesB = Rectangles(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber, slope: lineBSlope)
            rectanglesB.setColor(color: lineBColor)
            rectanglesB.setThick(thick: lineBThick)
        case Constants.typeHeart:
            heartsA = Hearts(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
            heartsA.setColor(color: lineAColor)
            heartsA.setThick(thick: lineAThick)
            heartsB = Hearts(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber)
            heartsB.setColor(color: lineBColor)
            heartsB.setThick(thick: lineBThick)
        case Constants.typeSynapse:
            synapsesA = Synapses(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
            synapsesA.setColor(color: lineAColor)
            synapsesA.setThick(thick: lineAThick)
            synapsesB = Synapses(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber)
            synapsesB.setColor(color: lineBColor)
            synapsesB.setThick(thick: lineBThick)
        case Constants.typeOriginal:
            originalsA = Originals(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
            originalsA.setColor(color: lineAColor)
            originalsA.setThick(thick: lineAThick)
            originalsB = Originals(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
            originalsB.setColor(color: lineBColor)
            originalsB.setThick(thick: lineBThick)
        default:
            #if DEBUG
            print("IllegalArgument on update")
            #endif
        }
        
    }
    
    func touchMove(_ whichLine: Int, dx: CGFloat, dy: CGFloat) {
        switch moireType {
        case Constants.typeLine:
            if(whichLine == lineA) {
                linesA.touchMove(dx: dx, dy: dy)
//                linesA.checkOutOfRange(frameWidth)
//                linesA.draw()
            }
            else {
                linesB.touchMove(dx: dx, dy: dy)
//                linesB.checkOutOfRange(frameWidth)
//                linesB.draw()
            }
        case Constants.typeCircle:
            if(whichLine == lineA) {
                circlesA.touchMove(dx: dx, dy: dy)
//                circlesA.checkOutOfRange(frameWidth)
//                circlesA.draw()
            }
            else {
                circlesB.touchMove(dx: dx, dy: dy)
//                circlesB.checkOutOfRange(frameWidth)
//                circlesB.draw()
            }
        case Constants.typeRect:
            if(whichLine == lineA) {
                rectanglesA.touchMove(dx: dx, dy: dy)
//                rectanglesA.checkOutOfRange(frameWidth)
//                rectanglesA.draw()
            }
            else {
                rectanglesB.touchMove(dx: dx, dy: dy)
//                rectanglesB.checkOutOfRange(frameWidth)
//                rectanglesB.draw()
            }
        case Constants.typeHeart:
            if(whichLine == lineA) {
                heartsA.touchMove(dx: dx, dy: dy)
//                heartsA.checkOutOfRange(frameWidth)
//                heartsA.draw()
            }
            else {
                heartsB.touchMove(dx: dx, dy: dy)
//                heartsB.checkOutOfRange(frameWidth)
//                heartsB.draw()
            }
        case Constants.typeSynapse:
            if(whichLine == lineA) {
                synapsesA.touchMove(dx: dx, dy: dy)
                //                synapsesA.checkOutOfRange(frameWidth)
                //                synapsesA.draw()
            }
            else {
                synapsesB.touchMove(dx: dx, dy: dy)
                //                synapsesB.checkOutOfRange(frameWidth)
                //                synapsesB.draw()
            }
//        case typeOriginal:
//            print("typeOriginal")
            
        default:
            #if DEBUG
            print("default")
            #endif
        }
    }
    
    func touchOriginalMove(_ whichLine: Int, movePoint: CGPoint) {
        
        if(whichLine == lineA) {
            originalsA.touchMove(movePoint: movePoint)
//            originalsA.checkOutOfRange(frameWidth)
            originalsA.draw()
        }
        else {
            originalsB.touchMove(movePoint: movePoint)
//            originalsB.checkOutOfRange(frameWidth)
            originalsB.draw()
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
        
        switch moireType {
//        case Constants.typeLine:
//        case Constants.typeCircle:
//        case Constants.typeRect:
//        case Constants.typeHeart:
        case Constants.typeOriginal:
            // touch down
            if(isTouching) {
                if(touchingLine == lineA) {
                    originalsA.start(firstPoint: firstPoint)
                }
                else {
                    originalsB.start(firstPoint: firstPoint)
                }
            }
                // touch up
            else {
                if(touchingLine == lineA) {
                    originalsA.end()
                }
                else {
                    originalsB.end()
                }
            }
        default:
            #if DEBUG
            print("default")
            #endif
        }
    }

}
