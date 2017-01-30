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
    
    var originals = [Original]()
    
    var drawRange: CGFloat = 0
    
    init(whichLine: Int, frameWidth: Int, frameHeight: Int, number: Int){
        super.init(number: number)
        
        drawRange = CGFloat(frameHeight)*2/3
        
        for _ in 0..<self.number {
            if(whichLine == lineA){
                originals.append(Original())
            }
            else {
                originals.append(Original())
            }
        }
    }
    
    override func draw(){
        super.draw()
        
        for i in 0..<originals.count {
            originals[i].path.lineWidth = CGFloat(thick)
            originals[i].path.stroke()
        }
    }
    
    override func checkOutOfRange(frameWidth :Int){
        for i in 0..<originals.count {
            originals[i].checkOutOfRange(frameWidth)
        }
    }
    
    override func move(whichLine :Int){
        if(whichLine == lineA) {
            for i in 0..<originals.count {
                originals[i].autoMove(dx)
            }
        }
        else {
            for i in 0..<originals.count {
                originals[i].autoMove(-dx)
            }
        }
    }
    
    func start(firstPoint: CGPoint) {
        let margin: CGFloat = drawRange/CGFloat(originals.count)
        for i in 0..<originals.count {
            let tempPointX: CGFloat = firstPoint.x - drawRange/2 + margin*CGFloat(i)
            originals[i].start(CGPoint(x: tempPointX, y: firstPoint.y))
            
            print("firstPoint i : ", i)
            print("firstPoint x : ", tempPointX)
            print("firstPoint y : ", firstPoint.y)
        }
    }
    
    func touchMove(movePoint: CGPoint) {
        let margin: CGFloat = drawRange/CGFloat(originals.count)
        for i in 0..<originals.count {
            let tempPointX: CGFloat = movePoint.x - drawRange/2 + margin*CGFloat(i)
            originals[i].touchMove(CGPoint(x: tempPointX, y: movePoint.y))
            
            print("movePoint i : ", i)
            print("movePoint x : ", tempPointX)
            print("movePoint y : ", movePoint.y)
        }
    }
    
    func end() {
        
    }
}