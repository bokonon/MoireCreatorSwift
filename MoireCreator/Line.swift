//
//  Line.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/01.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Line: BaseType {
    
    var startPoint: CGPoint!
    
    var endPoint: CGPoint!
    
    var path: UIBezierPath!
    
    override init(){
        super.init()
    }
    
    init(frameHeight: Int, slope: Int, basePoint: Int, arg: Int){
        path = UIBezierPath()
        startPoint = CGPoint(x: basePoint - arg, y: 0)
        endPoint = CGPoint(x: Int(startPoint.x) - slope + arg*2, y: frameHeight)
        path.removeAllPoints()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
    }
    
    override func autoMove(_ dx :CGFloat){
        startPoint.x += dx
        endPoint.x += dx
        setPath()
    }
    
    override func touchMove(_ dx :CGFloat, dy :CGFloat){
        startPoint.x += dx
        endPoint.x += dx
//        startPoint.y += dy
//        endPoint.y += dy
        setPath()
    }
    
    override func checkOutOfRange(_ frameWidth :Int, slope :Int){
        // LineB
        if(endPoint.x < startPoint.x) {
            if(frameWidth < Int(endPoint.x)) {
                let diff: Float = Float(Int(endPoint.x) - frameWidth)
                endPoint.x = CGFloat(Float(-slope) + diff)
                startPoint.x = endPoint.x + CGFloat(slope)
                setPath()
            }
            else if(startPoint.x < 0) {
                let diff: Float = Float(-startPoint.x)
                endPoint.x = CGFloat(Float(frameWidth) - diff)
                startPoint.x = endPoint.x + CGFloat(slope)
                setPath()
            }
        }
        // LineA
        else {
            if(endPoint.x < 0) {
                let diff: Float = -Float(endPoint.x)
                startPoint.x = CGFloat(Float(frameWidth) - diff)
                endPoint.x = startPoint.x + CGFloat(slope)
                setPath()
            }
            else if(frameWidth < Int(startPoint.x)) {
                let diff: Float = Float(startPoint.x) - Float(frameWidth)
                startPoint.x = CGFloat(Float(-slope) + diff)
                endPoint.x = startPoint.x + CGFloat(slope)
                setPath()
            }
        }
    }
    
    func setPath(){
        path.removeAllPoints()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
    }
    
}
