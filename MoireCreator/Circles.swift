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
    
    var circles = [Circle]()
    
    // arg is magic number for A or B
    init(whichLine: Int, frameWidth: Int, frameHeight: Int, number: Int){
        super.init(number: number)
        let maxRadius = CGFloat(frameHeight)/3.0
        for i in 0..<self.number {
            if(whichLine == lineA){
                circles.append(Circle(point: CGPoint(x: 0,y: CGFloat(frameHeight)/CGFloat(3)), radius: maxRadius/CGFloat(number)*CGFloat(i)))
            }
            else {
                circles.append(Circle(point: CGPoint(x: CGFloat(frameWidth),y: CGFloat(frameHeight)*CGFloat(2)/CGFloat(3)), radius: maxRadius/CGFloat(number)*CGFloat(i)))
            }
        }
    }
    
    override func draw(){
        
        super.draw()
        
        for i in 0..<circles.count {
            
            // for debug change color of first line
//            if(i == 0){
//                UIColor.redColor().setStroke()
//            }
//            else {
//                UIColor.blackColor().setStroke()
//            }
            
            circles[i].path.lineWidth = CGFloat(thick)
            circles[i].path.stroke()
        }
    }
    
    override func checkOutOfRange(frameWidth :Int){
        if(CGFloat(frameWidth) < circles[number-1].centerPoint.x - circles[number-1].radius) {
            for i in 0..<circles.count {
                circles[i].checkOutOfRange(frameWidth)
            }
        }
        else if(circles[number-1].centerPoint.x + circles[number-1].radius < 0) {
            for i in 0..<circles.count {
                circles[i].checkOutOfRange(frameWidth)
            }
        }
    }
    
    override func move(whichLine :Int){
        if(whichLine == lineA) {
            for i in 0..<circles.count {
                circles[i].autoMove(dx);
            }
            
        }
        else if(whichLine == lineB) {
            for j in 0..<circles.count {
                circles[j].autoMove(-dx);
            }
        }
    }
    
    override func touchMove(dx: CGFloat, dy: CGFloat){
        for i in 0..<circles.count {
            circles[i].touchMove(dx, dy: dy);
        }
    }
}
