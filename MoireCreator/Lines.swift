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
    
    var lines = [Line]()
    
    // arg is magic number for A or B
    init(whichLine: Int, frameWidth: Int, frameHeight: Int, number: Int, slope: Int){
        super.init(number: number)
        self.slope = slope
        for i in 0..<self.number {
            if(whichLine == lineA){
                lines.append(Line(frameHeight: frameHeight, slope: slope, basePoint: Int(Float(frameWidth + slope) / Float(number) * Float(i)), arg: 0))
            }
            else {
                lines.append(Line(frameHeight: frameHeight, slope: slope, basePoint: Int(Float(frameWidth + slope) / Float(number) * Float(i)), arg: slope))
            }
        }
    }
    
    override func draw(){
        
        super.draw()
        
        for i in 0..<lines.count {
            
//            // for debug change color of first line
//            if(i == 0){
//                UIColor.redColor().setStroke()
//            }
//            else {
//                UIColor.blackColor().setStroke()
//            }
            
            lines[i].path.lineWidth = CGFloat(thick)
            lines[i].path.stroke()
        }
    }
    
    override func checkOutOfRange(frameWidth :Int){
        for i in 0..<lines.count {
            lines[i].checkOutOfRange(frameWidth, slope: slope)
        }
    }
    
    override func move(whichLine :Int){
        if(whichLine == lineA) {
            for i in 0..<lines.count {
                lines[i].autoMove(dx);
            }
            
        }
        else if(whichLine == lineB) {
            for j in 0..<lines.count {
                lines[j].autoMove(-dx);
            }
        }
    }
    
    override func touchMove(dx: CGFloat, dy: CGFloat){
        for i in 0..<lines.count {
            lines[i].touchMove(dx, dy: dy);
        }
    }
    
//    override func setNumber(number: Int) {
//        super.setNumber(number)
//        
//    }
}
