//
//  Originals.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/23.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class Originals: BaseTypes {
    
    var original = [Original]()
    
    var drawRange: CGFloat = 0
    
    init(whichLine: Int, frameWidth: Int, frameHeight: Int, number: Int){
        super.init(number: number)
        
        drawRange = CGFloat(frameHeight)*2/3
        
        for _ in 0..<self.number {
            if(whichLine == lineA){
                original.append(Original())
            }
            else {
                original.append(Original())
            }
        }
    }
    
    override func draw(){
        super.draw()
        
        for i in 0..<original.count {
            original[i].path.lineWidth = CGFloat(thick)
            original[i].path.stroke()
        }
    }
    
    override func checkOutOfRange(frameWidth :Int){
        for i in 0..<original.count {
            original[i].checkOutOfRange(frameWidth: frameWidth)
        }
    }
    
    override func move(whichLine :Int){
        if(whichLine == lineA) {
            for i in 0..<original.count {
                original[i].autoMove(dx: dx)
            }
        }
        else {
            for i in 0..<original.count {
                original[i].autoMove(dx: -dx)
            }
        }
    }
    
    override func start(firstPoint: CGPoint) {
        let margin: CGFloat = drawRange/CGFloat(original.count)
        for i in 0..<original.count {
            let tempPointX: CGFloat = firstPoint.x - drawRange/2 + margin*CGFloat(i)
            original[i].start(firstPoint: CGPoint(x: tempPointX, y: firstPoint.y))
            
            #if DEBUG
            print("firstPoint i : ", i)
            print("firstPoint x : ", tempPointX)
            print("firstPoint y : ", firstPoint.y)
            #endif
        }
    }
    
    override func touchMove(movePoint: CGPoint) {
        let margin: CGFloat = drawRange/CGFloat(original.count)
        for i in 0..<original.count {
            let tempPointX: CGFloat = movePoint.x - drawRange/2 + margin*CGFloat(i)
            original[i].touchMove(movePoint: CGPoint(x: tempPointX, y: movePoint.y))
            
            #if DEBUG
            print("movePoint i : ", i)
            print("movePoint x : ", tempPointX)
            print("movePoint y : ", movePoint.y)
            #endif
        }
    }
    
    override func end() {
        
    }
}
