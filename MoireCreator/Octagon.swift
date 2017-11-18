//
//  Plus.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/12.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

extension BinaryInteger {
    var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
    var adjustDegree: Self {
        if self > 360 {
            return self - 360
        } else if (self < 0) {
            return 360 + self
        }
        return self
    }
}

class Octagon: BaseType {
    
    let lineA: Int = 0
    let lineB: Int = 1
    
    var centerPoint: CGPoint!
    
    var length: CGFloat!
    
    var degrees: CGFloat = 0
    
    var leftTopPoint: CGPoint!
    
    var leftBottomPoint: CGPoint!
    
    var topLeftPoint: CGPoint!
    
    var topRightPoint: CGPoint!
    
    var rightTopPoint: CGPoint!
    
    var rightBottomPoint: CGPoint!
    
    var bottomRightPoint: CGPoint!
    
    var bottomLeftPoint: CGPoint!
    
    var path: UIBezierPath!
    
    var thick: Int = 1
    
    let leftTopDegreesMargin:CGFloat = 250
    
    let leftBottomDegreesMargin:CGFloat = 290
    
    let topLeftDegreeMargin:CGFloat = -20
    
    let topRightDegreeMargin:CGFloat = 20
    
    let rightTopDegreeMargin:CGFloat = 70
    
    let rightBottomDegreeMargin:CGFloat = 110
    
    let bottomRightDegreeMargin:CGFloat = 160
    
    let bottomLeftDegreeMargin:CGFloat = 200
    
    override init(){
        super.init()
    }
    
    init(frameHeight: Int, centerPoint: CGPoint, whichLine: Int, length: CGFloat){
        super.init()
        
        path = UIBezierPath()
        
        self.centerPoint = centerPoint
        self.length = length
        
        // x2 = x1 + r × cosθ
        // y2 = y1 – r × sinθ
        
        leftBottomPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + leftTopDegreesMargin).adjustDegree)
        leftTopPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + leftBottomDegreesMargin).adjustDegree)
        
        topLeftPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + topLeftDegreeMargin).adjustDegree)
        topRightPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + topRightDegreeMargin).adjustDegree)
        
        rightTopPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + rightTopDegreeMargin).adjustDegree)
        rightBottomPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + rightBottomDegreeMargin).adjustDegree)
        
        bottomRightPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + bottomRightDegreeMargin).adjustDegree)
        bottomLeftPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + bottomLeftDegreeMargin).adjustDegree)
        
        path.removeAllPoints()
        path.move(to: leftBottomPoint)
        path.addLine(to: leftTopPoint)
        path.addLine(to: topLeftPoint)
        path.addLine(to: topRightPoint)
        path.addLine(to: rightTopPoint)
        path.addLine(to: rightBottomPoint)
        path.addLine(to: bottomRightPoint)
        path.addLine(to: bottomLeftPoint)
        path.addLine(to: leftBottomPoint)
    }
    
    override func autoMove(dx :CGFloat){
        degrees += 2
        #if DEBUG
        Log.d("degree : ", degrees)
        #endif
        if degrees >= 360 {
            degrees = degrees - 360
        }
        centerPoint.x += dx
        leftBottomPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + leftTopDegreesMargin).adjustDegree)
        leftTopPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + leftBottomDegreesMargin).adjustDegree)
        topLeftPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + topLeftDegreeMargin).adjustDegree)
        topRightPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + topRightDegreeMargin).adjustDegree)
        rightTopPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + rightTopDegreeMargin).adjustDegree)
        rightBottomPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + rightBottomDegreeMargin).adjustDegree)
        bottomRightPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + bottomRightDegreeMargin).adjustDegree)
        bottomLeftPoint = self.getPoint(centerPoint: centerPoint, length: length, degrees: (degrees + bottomLeftDegreeMargin).adjustDegree)
        
        setPath()
    }
    
    override func touchMove(dx :CGFloat, dy :CGFloat){
        centerPoint.x += dx
        centerPoint.y += dy
        
        leftTopPoint.x += dx
        leftTopPoint.y += dy
        leftBottomPoint.x += dx
        leftBottomPoint.y += dy
        
        topLeftPoint.x += dx
        topLeftPoint.y += dy
        topRightPoint.x += dx
        topRightPoint.y += dy
        
        rightTopPoint.x += dx
        rightTopPoint.y += dy
        rightBottomPoint.x += dx
        rightBottomPoint.y += dy
        
        bottomRightPoint.x += dx
        bottomRightPoint.y += dy
        bottomLeftPoint.x += dx
        bottomLeftPoint.y += dy
        
        setPath()
    }
    
    func checkOutOfRange(frameWidth :Int, whichLine :Int, centerX: CGFloat){
        centerPoint.x = centerX
        leftBottomPoint.x = self.getPointX(centerPointX: centerX, length: length, degrees: (degrees + leftTopDegreesMargin).adjustDegree)
        leftTopPoint.x = self.getPointX(centerPointX: centerX, length: length, degrees: (degrees + leftBottomDegreesMargin).adjustDegree)
        topLeftPoint.x = self.getPointX(centerPointX: centerX, length: length, degrees: (degrees + topLeftDegreeMargin).adjustDegree)
        topRightPoint.x = self.getPointX(centerPointX: centerX, length: length, degrees: (degrees + topRightDegreeMargin).adjustDegree)
        rightTopPoint.x = self.getPointX(centerPointX: centerX, length: length, degrees: (degrees + rightTopDegreeMargin).adjustDegree)
        rightBottomPoint.x = self.getPointX(centerPointX: centerX, length: length, degrees: (degrees + rightBottomDegreeMargin).adjustDegree)
        bottomRightPoint.x = self.getPointX(centerPointX: centerX, length: length, degrees: (degrees + bottomRightDegreeMargin).adjustDegree)
        bottomLeftPoint.x = self.getPointX(centerPointX: centerX, length: length, degrees: (degrees + bottomLeftDegreeMargin).adjustDegree)
        
        setPath()
    }
    
    func getPoint(centerPoint: CGPoint, length: CGFloat, degrees: CGFloat) -> CGPoint {
        return CGPoint(x: centerPoint.x + length * cos(degrees.degreesToRadians),
                                   y: centerPoint.y - length * sin(degrees.degreesToRadians))
    }
    
    func getPointX(centerPointX: CGFloat, length: CGFloat, degrees: CGFloat) -> CGFloat {
        return centerPointX + length * cos(degrees.degreesToRadians)
    }
    
    func setPath(){
        path.removeAllPoints()
        path.move(to: leftBottomPoint)
        path.addLine(to: leftTopPoint)
        path.addLine(to: topLeftPoint)
        path.addLine(to: topRightPoint)
        path.addLine(to: rightTopPoint)
        path.addLine(to: rightBottomPoint)
        path.addLine(to: bottomRightPoint)
        path.addLine(to: bottomLeftPoint)
        path.addLine(to: leftBottomPoint)
    }
    
    func setThick(thick: Int) {
        self.thick = thick
    }
    
}
