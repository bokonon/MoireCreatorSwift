//
//  Hearts.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/06/20.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class Hearts: BaseTypes {
    
    var heart = [Heart]()
    
    init(whichLine: Int, frameWidth: Int, frameHeight: Int, number: Int){
        super.init(number: number)
        
        for i in 0..<self.number {
            let heartWidth = CGFloat(frameWidth / number * (i + 1))
            let heartHeight = CGFloat(frameHeight * 2 / 3 / number * (i + 1))
            if (whichLine == lineA) {
                heart.append(Heart(centerX: 0, centerY: CGFloat(frameHeight) * 5 / 18, width: heartWidth, height: heartHeight))
            } else if (whichLine == lineB) {
                heart.append(Heart(centerX: CGFloat(frameWidth), centerY: CGFloat(frameHeight * 2 / 3), width: heartWidth, height: heartHeight))
            }
        }
    }
    
    override func draw(){
        
        super.draw()
        
        for i in 0..<heart.count {
            
            // change color of first and last lines for debug
            #if DEBUG
            if(i == 0){
                UIColor.red.setStroke()
            }
            else if (i == heart.count - 1) {
                UIColor.blue.setStroke()
            }
            else {
                UIColor.black.setStroke()
            }
            #endif
            
            heart[i].path.lineWidth = CGFloat(thick)
            heart[i].path.stroke()
        }
    }
    
    override func checkOutOfRange(frameWidth :Int, frameHeight :Int, whichLine :Int){
        if (heart[number - 1].rightTop[0].x < 0) {
            // disappear for less than 0
            for i in 0..<heart.count {
                heart[i].checkOutOfRange(centerX: CGFloat(frameWidth) + heart[number - 1].width / 2,
                                         centerY: heart[i].centerTop.y + (heart[i].height / 2 - heart[i].height / 5))
            }
        } else if (CGFloat(frameWidth) < heart[number - 1].leftTop[1].x) {
            // disappear for more than width
            for i in 0..<heart.count {
                let centerX = -heart[number - 1].width / 2
                let centerY = heart[i].centerTop.y + (heart[i].height / 2 - heart[i].height / 5)
                heart[i].checkOutOfRange(centerX: centerX,
                                         centerY: centerY)
            }
        }
    }
    
    override func move(whichLine :Int){
        if(whichLine == lineA) {
            for i in 0..<heart.count {
                heart[i].autoMove(dx: dx)
            }
        }
        else if(whichLine == lineB) {
            for i in 0..<heart.count {
                heart[i].autoMove(dx: -dx)
            }
        }
    }
    
    override func touchMove(dx: CGFloat, dy: CGFloat){
        for i in 0..<heart.count {
            heart[i].touchMove(dx: dx, dy: dy);
        }
    }
    
    override func setThick(thick: Int) {
        self.thick = thick
        for i in 0..<heart.count {
            heart[i].setThick(thick: thick)
        }
    }
}
