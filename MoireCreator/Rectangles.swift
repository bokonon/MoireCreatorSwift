//
//  Rectangles.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/21.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class Rectangles: BaseTypes {
    
    var rectangles = [Rectangle]()
    
    // arg is magic number for A or B
    init(whichLine: Int, frameWidth: Int, frameHeight: Int, number: Int, slope: Int){
        super.init(number: number)
        self.slope = slope
        let maxLength = CGFloat(frameHeight)/3.0*2
        for i in 0..<self.number {
            if(whichLine == lineA){
                rectangles.append(Rectangle(frameHeight: frameHeight, slope: (Int)(CGFloat(slope)/CGFloat(number)*CGFloat(i)), centerPoint: CGPoint(x: 0,y: CGFloat(frameHeight)/3), whichLine: lineA, length: maxLength/CGFloat(number)*CGFloat(i)))
            }
            else {
                rectangles.append(Rectangle(frameHeight: frameHeight, slope: (Int)(CGFloat(slope)/CGFloat(number)*CGFloat(i)), centerPoint: CGPoint(x: CGFloat(frameWidth),y: CGFloat(frameHeight)*CGFloat(2)/3), whichLine: lineB, length: maxLength/CGFloat(number)*CGFloat(i)))
            }
        }
    }
    
    override func draw(){
        
        super.draw()
        
        for i in 0..<rectangles.count {
            
            //            // for debug change color of first line
            //            if(i == 0){
            //                UIColor.redColor().setStroke()
            //            }
            //            else {
            //                UIColor.blackColor().setStroke()
            //            }
            
            rectangles[i].path.lineWidth = CGFloat(thick)
            rectangles[i].path.stroke()
        }
    }
    
    func checkOutOfRange(_ frameWidth :Int, frameHeight :Int, whichLine :Int){
        // LineA //
        if(whichLine == lineA) {
            if(CGFloat(frameWidth) < rectangles[number-1].leftBottomPoint.x) {
                let diff: CGFloat = rectangles[number-1].leftBottomPoint.x - CGFloat(frameWidth)
                let centerX: CGFloat = -CGFloat(frameHeight)/3 + diff - CGFloat(slope)
                for i in 0..<rectangles.count {
                    rectangles[i].checkOutOfRange(frameWidth, slope: (Int)(CGFloat(slope)/CGFloat(number)*CGFloat(i)), whichLine: lineA, centerX: centerX)
                }
            }
            else if(rectangles[number-1].rightTopPoint.x < 0) {
                let diff: CGFloat = rectangles[number-1].rightTopPoint.x
                let centerX: CGFloat = CGFloat(frameWidth) + CGFloat(frameHeight)/3 - diff + CGFloat(slope)
                for i in 0..<rectangles.count {
                    rectangles[i].checkOutOfRange(frameWidth, slope: (Int)(CGFloat(slope)/CGFloat(number)*CGFloat(i)), whichLine: lineA, centerX: centerX)
                }
            }
        }
        // LineB \\
        else {
            if(CGFloat(frameWidth) < rectangles[number-1].leftTopPoint.x) {
                let diff: CGFloat = rectangles[number-1].leftTopPoint.x - CGFloat(frameWidth)
                let centerX: CGFloat = -CGFloat(frameHeight)/3 + diff - CGFloat(slope)
                for i in 0..<rectangles.count {
                    rectangles[i].checkOutOfRange(frameWidth, slope: (Int)(CGFloat(slope)/CGFloat(number)*CGFloat(i)), whichLine: lineB, centerX: centerX)
                }
            }
            else if(rectangles[number-1].rightBottomPoint.x < 0) {
                let diff = CGFloat(rectangles[number-1].rightBottomPoint.x)
                let centerX = CGFloat(frameWidth) + CGFloat(frameHeight)/3 + diff + CGFloat(slope)
                for i in 0..<rectangles.count {
                    rectangles[i].checkOutOfRange(frameWidth, slope: (Int)(CGFloat(slope)/CGFloat(number)*CGFloat(i)), whichLine: lineB, centerX: centerX)
                }
            }
        }
    }
    
    override func move(_ whichLine :Int){
        if(whichLine == lineA) {
            for i in 0..<rectangles.count {
                rectangles[i].autoMove(dx);
            }
            
        }
        else if(whichLine == lineB) {
            for j in 0..<rectangles.count {
                rectangles[j].autoMove(-dx);
            }
        }
    }
    
    override func touchMove(_ dx: CGFloat, dy: CGFloat){
        for i in 0..<rectangles.count {
            rectangles[i].touchMove(dx, dy: dy);
        }
    }
    
    override func setThick(_ thick: Int) {
        self.thick = thick
        for i in 0..<rectangles.count {
            rectangles[i].setThick(thick)
        }
    }
}
