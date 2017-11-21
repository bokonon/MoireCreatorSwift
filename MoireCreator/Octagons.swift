//
//  Pluses.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/12.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class Octagons: BaseTypes {
    
    var octagons = [Octagon]()
    
    init(whichLine: Int, frameWidth: Int, frameHeight: Int, number: Int){
        super.init(number: number)
        
        let maxLength = CGFloat(frameHeight)/3.0
        for i in 0..<self.number {
            if(whichLine == lineA){
                octagons.append(Octagon(frameHeight: frameHeight, centerPoint: CGPoint(x: 0,y: CGFloat(frameHeight)/3), whichLine: lineA, length: maxLength/CGFloat(number)*CGFloat(i)))
            }
            else {
                octagons.append(Octagon(frameHeight: frameHeight, centerPoint: CGPoint(x: CGFloat(frameWidth),y: CGFloat(frameHeight)*CGFloat(2)/3), whichLine: lineB, length: maxLength/CGFloat(number)*CGFloat(i)))
            }
        }
    }
    
    override func draw(){
        
        super.draw()
        
        for i in 0..<octagons.count {
            
            // change color of first and last lines for debug
            #if DEBUG
                if(i == 0){
                    UIColor.red.setStroke()
                }
                else if (i == rectangle.count - 1) {
                    UIColor.blue.setStroke()
                }
                else {
                    UIColor.black.setStroke()
                }
            #endif
            
            octagons[i].path.lineWidth = CGFloat(thick)
            octagons[i].path.stroke()
        }
    }
    
    override func checkOutOfRange(frameWidth :Int, frameHeight :Int, whichLine :Int){
        // LineA
        if(whichLine == lineA) {
            if(CGFloat(frameWidth) < octagons[number-1].centerPoint.x - octagons[number-1].length) {
                let diff: CGFloat = octagons[number-1].centerPoint.x - octagons[number-1].length - CGFloat(frameWidth)
                let centerX: CGFloat = -CGFloat(frameHeight)/3 + diff
                for i in 0..<octagons.count {
                    octagons[i].checkOutOfRange(frameWidth: frameWidth, whichLine: lineA, centerX: centerX)
                }
            }
            else if(octagons[number-1].centerPoint.x + octagons[number-1].length < 0) {
                let diff: CGFloat = -(octagons[number-1].centerPoint.x + octagons[number-1].length)
                let centerX: CGFloat = CGFloat(frameWidth) + CGFloat(frameHeight)/3 - diff
                for i in 0..<octagons.count {
                    octagons[i].checkOutOfRange(frameWidth: frameWidth, whichLine: lineA, centerX: centerX)
                }
            }
        }
        // LineB
        else {
            if(CGFloat(frameWidth) < octagons[number-1].centerPoint.x - octagons[number-1].length) {
                let diff: CGFloat = octagons[number-1].centerPoint.x - octagons[number-1].length - CGFloat(frameWidth)
                let centerX: CGFloat = -CGFloat(frameHeight)/3 + diff
                for i in 0..<octagons.count {
                    octagons[i].checkOutOfRange(frameWidth: frameWidth, whichLine: lineB, centerX: centerX)
                }
            }
            else if(octagons[number-1].centerPoint.x + octagons[number-1].length < 0) {
                let diff = -(octagons[number-1].centerPoint.x + octagons[number-1].length)
                let centerX = CGFloat(frameWidth) + CGFloat(frameHeight)/3 - diff
                for i in 0..<octagons.count {
                    octagons[i].checkOutOfRange(frameWidth: frameWidth, whichLine: lineB, centerX: centerX)
                }
            }
        }
    }
    
    override func move(whichLine :Int){
        if(whichLine == lineA) {
            for i in 0..<octagons.count {
                octagons[i].autoMove(dx: dx);
            }
            
        }
        else if(whichLine == lineB) {
            for j in 0..<octagons.count {
                octagons[j].autoMove(dx: -dx);
            }
        }
    }
    
    override func touchMove(dx: CGFloat, dy: CGFloat){
        for i in 0..<octagons.count {
            octagons[i].touchMove(dx: dx, dy: dy);
        }
    }
    
    override func setThick(thick: Int) {
        self.thick = thick
        for i in 0..<octagons.count {
            octagons[i].setThick(thick: thick)
        }
    }
}
