//
//  Original.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/23.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Original: BaseType {
    
    var path: UIBezierPath!
    var points = [CGPoint]()
    
    override init(){
        super.init()
        path = UIBezierPath()
    }
    
    override func autoMove(dx :CGFloat){
        for i in 0..<self.points.count {
            if(i == 0) {
                let firstPoint: CGPoint = CGPoint(x: self.points[i].x + dx, y: self.points[i].y)
                path.removeAllPoints()
                path.move(to: firstPoint)
                
                points[i] = firstPoint
            }
            else {
                let tempPoint: CGPoint = CGPoint(x: self.points[i].x + dx, y: self.points[i].y)
                path.addLine(to: tempPoint)
                points[i] = tempPoint
            }
        }
    }
    
    override func checkOutOfRange(frameWidth :Int){
        var min: CGFloat = 0
        var max: CGFloat = 0
        for i in 0..<self.points.count {
            if(i == 0) {
                min = points[i].x
                max = points[i].x
            }
            else {
                if(points[i].x < min) {
                    min = points[i].x
                }
                else if(max < points[i].x) {
                    max = points[i].x
                }
            }
        }
        if(max < 0) {
            for i in 0..<self.points.count {
                if(i == 0) {
                    let firstPoint: CGPoint = CGPoint(x: CGFloat(frameWidth) - min + self.points[i].x, y: self.points[i].y)
                    path.removeAllPoints()
                    path.move(to: firstPoint)
                    
                    points[i] = firstPoint
                }
                else {
                    let tempPoint: CGPoint = CGPoint(x: CGFloat(frameWidth) - min + self.points[i].x, y: self.points[i].y)
                    path.addLine(to: tempPoint)
                    points[i] = tempPoint
                }
            }
        }
        else if(CGFloat(frameWidth) < min){
            for i in 0..<self.points.count {
                let baseDiff: CGFloat = max - CGFloat(frameWidth)
                let tempDiff: CGFloat = self.points[i].x - CGFloat(frameWidth)
                if(i == 0) {
                    let firstPoint: CGPoint = CGPoint(x: tempDiff - baseDiff, y: self.points[i].y)
                    path.removeAllPoints()
                    path.move(to: firstPoint)
                    
                    points[i] = firstPoint
                }
                else {
                    let tempPoint: CGPoint = CGPoint(x: tempDiff - baseDiff, y: self.points[i].y)
                    path.addLine(to: tempPoint)
                    points[i] = tempPoint
                }
            }
        }
    }
    
    func start(firstPoint :CGPoint) {
        path.removeAllPoints()
        path.move(to: firstPoint)
        
        points.removeAll()
        points.append(firstPoint)
    }
    
    func touchMove(movePoint :CGPoint){
        path.addLine(to: movePoint)
        
        points.append(movePoint)
    }
    
}
