//
//  Circle.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/18.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Circle: BaseType {
    
    var centerPoint: CGPoint!
    
    var radius: CGFloat!
    
    var path: UIBezierPath!
    
    let start:CGFloat = 0.0
    let end :CGFloat = CGFloat(M_PI)*2
    
    override init(){
        super.init()
    }
    
    init(point: CGPoint, radius: CGFloat){
        self.centerPoint = point
        self.radius = radius
        path =  UIBezierPath(arcCenter: centerPoint, radius: self.radius,  startAngle: start, endAngle: end, clockwise: true)
        
    }
    
    override func autoMove(dx :CGFloat){
        centerPoint.x += dx
        setPath()
    }
    
    override func touchMove(dx :CGFloat, dy :CGFloat){
        centerPoint.x += dx
        centerPoint.y += dy
        setPath()
    }
    
    override func checkOutOfRange(frameWidth :Int){
        if(CGFloat(frameWidth) < centerPoint.x) {
            let diff: Float = Float(Int(centerPoint.x) - frameWidth)
            centerPoint.x = -CGFloat(diff)
            
            setPath()
        }
        else if(centerPoint.x < 0) {
            let diff: Float = Float(-centerPoint.x)
            centerPoint.x = CGFloat(Float(frameWidth) + diff)
            
            setPath()
        }
    }
    
    func setPath(){
        path.removeAllPoints()
        path =  UIBezierPath(arcCenter: centerPoint, radius: self.radius,  startAngle: start, endAngle: end, clockwise: true)
    }
    
}