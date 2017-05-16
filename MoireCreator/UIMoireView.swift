//
//  UIMoireView.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/01.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import UIKit

class UIMoireView: UIView {
    
    // TYPE_LINE
    let typeLine: Int = 0
    // TYPE_CIRCLE
    let typeCircle: Int = 1
    // TYPE_RECT
    let typeRect: Int = 2
    // TYPE_ORIGINAL
    let typeOriginal: Int = 3
    
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
        
        updateView()
    }
    
    // init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateView()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        switch moireType {
        case typeLine:
            linesA.checkOutOfRange(frameWidth)
            linesB.checkOutOfRange(frameWidth)
            
            if(!isPause){
                if(isTouchingLine == lineA && isTouching) {
                    // do nothing
                }
                else {
                    linesA.move(lineA)
                }
                if(isTouchingLine == lineB && isTouching) {
                    // do nothing
                }
                else {
                    linesB.move(lineB)
                }
            }
            linesA.draw()
            linesB.draw()
            // print("typeLine")
        case typeCircle:
            circlesA.checkOutOfRange(frameWidth)
            circlesB.checkOutOfRange(frameWidth)
            
            if(!isPause){
                if(isTouchingLine == lineB) {
                    circlesA.move(lineA)
                }
                else if(isTouchingLine == lineA && !isTouching){
                    circlesA.move(lineA)
                }
                if(isTouchingLine == lineA) {
                    circlesB.move(lineB)
                }
                else if(isTouchingLine == lineB && !isTouching){
                    circlesB.move(lineB)
                }
            }
            circlesA.draw()
            circlesB.draw()
            // print("typeCircle")
        case typeRect:
            rectanglesA.checkOutOfRange(frameWidth, frameHeight: frameHeight, whichLine: lineA)
            rectanglesB.checkOutOfRange(frameWidth, frameHeight: frameHeight, whichLine: lineB)
            
            if(!isPause){
                if(isTouchingLine == lineA && isTouching) {
                    // do nothing
                }
                else {
                    rectanglesA.move(lineA)
                }
                if(isTouchingLine == lineB && isTouching) {
                    // do nothing
                }
                else {
                    rectanglesB.move(lineB)
                }
            }
            rectanglesA.draw()
            rectanglesB.draw()
            // print("typeRect")
        case typeOriginal:
            if(!isPause){
                if(isTouchingLine == lineA && isTouching) {
                    // do nothing
                }
                else {
                    if(!isTouching) {
                        originalsA.checkOutOfRange(frameWidth)
                    }
                    originalsA.move(lineA)
                }
                if(isTouchingLine == lineB && isTouching) {
                    // do nothing
                }
                else {
                    if(!isTouching) {
                        originalsB.checkOutOfRange(frameWidth)
                    }
                    originalsB.move(lineB)
                }
            }
            originalsA.draw()
            originalsB.draw()
            
//            print("typeRect")
        default:
            print("default")
        }
    }
    
    func updateView() {
        frameWidth = Int(self.frame.width)
        frameHeight = Int(self.frame.height)
        
        print("frameWidth : ", frameWidth)
        print("frameHeight : ", frameHeight)
        
        // get userdefault
        let userDefault = UserDefaults.standard
        // set background preview color
        if let backgroundColorData  = userDefault.object(forKey: "backgroundColor") as? Data {
            if let backColor = NSKeyedUnarchiver.unarchiveObject(with: backgroundColorData) as? UIColor {
                self.backgroundColor = backColor
            }
        }
        else {
            self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        // set type
        moireType = userDefault.integer(forKey: "type")
        
        print("moireType : ", moireType)
        
        // set color
        let lineAColor: UIColor
        if let lineAColorData  = userDefault.object(forKey: "lineAColor") as? Data {
            lineAColor = (NSKeyedUnarchiver.unarchiveObject(with: lineAColorData) as? UIColor)!
        }
        else {
            lineAColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        let lineBColor: UIColor
        if let lineBColorData  = userDefault.object(forKey: "lineBColor") as? Data {
            lineBColor = (NSKeyedUnarchiver.unarchiveObject(with: lineBColorData) as? UIColor)!
        }
        else {
            lineBColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        
        // set number
        let lineANumber: Int = userDefault.integer(forKey: "lineANumber") ?? maxLines
        let lineBNumber: Int = userDefault.integer(forKey: "lineBNumber") ?? maxLines
        
        // set thick
        let lineAThick: Int = userDefault.integer(forKey: "lineAThick") ?? 1
        let lineBThick: Int = userDefault.integer(forKey: "lineBThick") ?? 1
        
        // set slope
        let lineASlope: Int = userDefault.integer(forKey: "lineASlope") ?? 10
        let lineBSlope: Int = userDefault.integer(forKey: "lineBSlope") ?? 10
        
        switch moireType {
        case typeLine:
            linesA = Lines(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber, slope: lineASlope)
            linesA.setColor(lineAColor)
            linesA.setThick(lineAThick)
            linesB = Lines(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber, slope: lineBSlope)
            linesB.setColor(lineBColor)
            linesB.setThick(lineBThick)
        case typeCircle:
            circlesA = Circles(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
            circlesA.setColor(lineAColor)
            circlesA.setThick(lineAThick)
            circlesB = Circles(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber)
            circlesB.setColor(lineBColor)
            circlesB.setThick(lineBThick)
        case typeRect:
            rectanglesA = Rectangles(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber, slope: lineASlope)
            rectanglesA.setColor(lineAColor)
            rectanglesA.setThick(lineAThick)
            rectanglesB = Rectangles(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineBNumber, slope: lineBSlope)
            rectanglesB.setColor(lineBColor)
            rectanglesB.setThick(lineBThick)
        case typeOriginal:
            originalsA = Originals(whichLine: lineA, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
            originalsA.setColor(lineAColor)
            originalsA.setThick(lineAThick)
            originalsB = Originals(whichLine: lineB, frameWidth: frameWidth, frameHeight: Int(frame.height), number: lineANumber)
            originalsB.setColor(lineBColor)
            originalsB.setThick(lineBThick)
        default:
            print("default")
        }
        
        print("update end")
        
    }
    
    func touchMove(_ whichLine: Int, dx: CGFloat, dy: CGFloat) {
        switch moireType {
        case typeLine:
            if(whichLine == lineA) {
                linesA.touchMove(dx, dy: dy)
//                linesA.checkOutOfRange(frameWidth)
//                linesA.draw()
            }
            else {
                linesB.touchMove(dx, dy: dy)
//                linesB.checkOutOfRange(frameWidth)
//                linesB.draw()
            }
        case typeCircle:
            if(whichLine == lineA) {
                circlesA.touchMove(dx, dy: dy)
//                circlesA.checkOutOfRange(frameWidth)
//                circlesA.draw()
            }
            else {
                circlesB.touchMove(dx, dy: dy)
//                circlesB.checkOutOfRange(frameWidth)
//                circlesB.draw()
            }
        case typeRect:
            if(whichLine == lineA) {
                rectanglesA.touchMove(dx, dy: dy)
//                rectanglesA.checkOutOfRange(frameWidth)
//                rectanglesA.draw()
            }
            else {
                rectanglesB.touchMove(dx, dy: dy)
//                rectanglesB.checkOutOfRange(frameWidth)
//                rectanglesB.draw()
            }
//        case typeOriginal:
//            print("typeOriginal")
            
        default:
            print("default")
        }
    }
    
    func touchOriginalMove(_ whichLine: Int, movePoint: CGPoint) {
        
        if(whichLine == lineA) {
            originalsA.touchMove(movePoint)
//            originalsA.checkOutOfRange(frameWidth)
            originalsA.draw()
        }
        else {
            originalsB.touchMove(movePoint)
//            originalsB.checkOutOfRange(frameWidth)
            originalsB.draw()
        }
    }

    func setOnpause(_ isPause: Bool) {
        self.isPause = isPause
    }
    
    func getOnPause() -> Bool{
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
        
        if(moireType == typeOriginal) {
            // touch down
            if(isTouching) {
                if(touchingLine == lineA) {
                    originalsA.start(firstPoint)
                }
                else {
                    originalsB.start(firstPoint)
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
        }
    }

}
