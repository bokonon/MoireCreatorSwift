//
//  Synapse.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/06/25.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Synapse: BaseType {
    
    var center: CGPoint
    var left: CGPoint
    var top: CGPoint
    var right: CGPoint
    var bottom: CGPoint
    
    var leftTop: CGPoint
    var leftBottom: CGPoint
    var rightTop: CGPoint
    var rightBottom: CGPoint
    
    var curveMargin: CGFloat = 15
    var path: UIBezierPath!
    
    var thick: Int = 1
    
    init(center: CGPoint, left: CGPoint, top: CGPoint, right: CGPoint, bottom: CGPoint) {
        
        self.center = center
        
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
        
        self.leftTop = CGPoint(x: left.x, y: top.y)
        self.leftBottom = CGPoint(x: left.x, y: bottom.y)
        self.rightTop = CGPoint(x: right.x, y: top.y)
        self.rightBottom = CGPoint(x: right.x, y: bottom.y)
        
        path = UIBezierPath()
        super.init()
        self.setPath()
    }
    
    override func autoMove(dx :CGFloat){
        // NOP
    }
    
    override func touchMove(dx :CGFloat, dy :CGFloat){
        // NOP
    }
    
    func autoMove(dx :CGFloat, margin :CGFloat){
        center.x += dx
        setMargin(margin: margin)
    }
    
    func touchMove(dx: CGFloat, dy: CGFloat, margin: CGFloat) {
        center.x += dx
        center.y += dy
        setMargin(margin: margin)
    }
    
    func setMargin(margin: CGFloat) {
        left.x = center.x - margin
        left.y = center.y
        top.x = center.x
        top.y = center.y - margin
        right.x = center.x + margin
        right.y = center.y
        bottom.x = center.x
        bottom.y = center.y + margin
    
        leftTop.x = left.x
        leftTop.y = top.y
    
        leftBottom.x = left.x
        leftBottom.y = bottom.y
    
        rightTop.x = right.x
        rightTop.y = top.y
    
        rightBottom.x = right.x
        rightBottom.y = bottom.y
    
        setPath()
    }
    
    func setPath(){
        path.removeAllPoints()
        
//        path.move(to: top)
//        path.addCurve(to: leftTop,
//                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(345.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(345.0 * CGFloat.pi / 180)),
//                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(330.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(330.0 * CGFloat.pi / 180)))
//        
//        path.move(to: leftTop)
//        path.addCurve(to: left,
//                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(300.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(300.0 * CGFloat.pi / 180)),
//                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(285.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(285.0 * CGFloat.pi / 180)))
//        
//        path.move(to: left)
//        path.addCurve(to: leftBottom,
//                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(255.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(255.0 * CGFloat.pi / 180)),
//                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(240.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(240.0 * CGFloat.pi / 180)))
//        
//        path.move(to: leftBottom)
//        path.addCurve(to: bottom,
//                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(210.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(210.0 * CGFloat.pi / 180)),
//                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(195.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(195.0 * CGFloat.pi / 180)))
//        
//        path.move(to: bottom)
//        path.addCurve(to: rightBottom,
//                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(165.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(165.0 * CGFloat.pi / 180)),
//                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(150.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(150.0 * CGFloat.pi / 180)))
//        
//        path.move(to: rightBottom)
//        path.addCurve(to: right,
//                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(120.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(120.0 * CGFloat.pi / 180)),
//                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(105.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(105.0 * CGFloat.pi / 180)))
//        
//        path.move(to: right)
//        path.addCurve(to: rightTop,
//                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(75.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(75.0 * CGFloat.pi / 180)),
//                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(60.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(60.0 * CGFloat.pi / 180)))
//        
//        path.move(to: rightTop)
//        path.addCurve(to: top,
//                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(30.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(30.0 * CGFloat.pi / 180)),
//                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(15.0 * CGFloat.pi / 180),
//                                             y: center.y + curveMargin * sin(15.0 * CGFloat.pi / 180)))
        
        path.move(to: top)
        path.addCurve(to: leftTop,
                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(345.0),
                                             y: center.y + curveMargin * sin(345.0)),
                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(330.0),
                                             y: center.y + curveMargin * sin(330.0)))
        
        path.move(to: leftTop)
        path.addCurve(to: left,
                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(300.0),
                                             y: center.y + curveMargin * sin(300.0)),
                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(285.0),
                                             y: center.y + curveMargin * sin(285.0)))
        
        path.move(to: left)
        path.addCurve(to: leftBottom,
                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(255.0),
                                             y: center.y + curveMargin * sin(255.0)),
                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(240.0),
                                             y: center.y + curveMargin * sin(240.0)))
        
        path.move(to: leftBottom)
        path.addCurve(to: bottom,
                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(210.0),
                                             y: center.y + curveMargin * sin(210.0)),
                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(195.0),
                                             y: center.y + curveMargin * sin(195.0)))
        
        path.move(to: bottom)
        path.addCurve(to: rightBottom,
                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(165.0),
                                             y: center.y + curveMargin * sin(165.0)),
                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(150.0),
                                             y: center.y + curveMargin * sin(150.0)))
        
        path.move(to: rightBottom)
        path.addCurve(to: right,
                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(120.0),
                                             y: center.y + curveMargin * sin(120.0)),
                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(105.0),
                                             y: center.y + curveMargin * sin(105.0)))
        
        path.move(to: right)
        path.addCurve(to: rightTop,
                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(75.0),
                                             y: center.y + curveMargin * sin(75.0)),
                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(60.0),
                                             y: center.y + curveMargin * sin(60.0)))
        
        path.move(to: rightTop)
        path.addCurve(to: top,
                      controlPoint1: CGPoint(x: center.x + curveMargin * cos(30.0),
                                             y: center.y + curveMargin * sin(30.0)),
                      controlPoint2: CGPoint(x: center.x + curveMargin * cos(15.0),
                                             y: center.y + curveMargin * sin(15.0)))
        
        
        // with addQuadCurve
//        path.move(to: top)
//        path.addQuadCurve(to: leftTop,
//                      controlPoint: CGPoint(x: center.x + curveMargin * cos(337.5),
//                                             y: center.y + curveMargin * sin(337.5)))
//        
//        path.move(to: leftTop)
//        path.addQuadCurve(to: left,
//                      controlPoint: CGPoint(x: center.x + curveMargin * cos(292.5),
//                                             y: center.y + curveMargin * sin(292.5)))
//        
//        path.move(to: left)
//        path.addQuadCurve(to: leftBottom,
//                      controlPoint: CGPoint(x: center.x + curveMargin * cos(247.5),
//                                             y: center.y + curveMargin * sin(247.5)))
//        
//        path.move(to: leftBottom)
//        path.addQuadCurve(to: bottom,
//                      controlPoint: CGPoint(x: center.x + curveMargin * cos(202.5),
//                                             y: center.y + curveMargin * sin(202.5)))
//        
//        path.move(to: bottom)
//        path.addQuadCurve(to: rightBottom,
//                      controlPoint: CGPoint(x: center.x + curveMargin * cos(157.5),
//                                             y: center.y + curveMargin * sin(157.5)))
//        
//        path.move(to: rightBottom)
//        path.addQuadCurve(to: right,
//                      controlPoint: CGPoint(x: center.x + curveMargin * cos(112.5),
//                                             y: center.y + curveMargin * sin(112.5)))
//        
//        path.move(to: right)
//        path.addQuadCurve(to: rightTop,
//                      controlPoint: CGPoint(x: center.x + curveMargin * cos(67.5),
//                                             y: center.y + curveMargin * sin(67.5)))
//        
//        path.move(to: rightTop)
//        path.addQuadCurve(to: top,
//                      controlPoint: CGPoint(x: center.x + curveMargin * cos(22.5),
//                                             y: center.y + curveMargin * sin(22.5)))
    }
    
    func setThick(thick: Int) {
        self.thick = thick
    }
}
