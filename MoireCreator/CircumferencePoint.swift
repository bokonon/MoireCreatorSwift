//
//  CircumferencePoint.swift
//  MoireCreator
//
//  Created by yuji shimada on 2018/04/02.
//  Copyright © 2018年 yuji shimada. All rights reserved.
//

import Foundation
import CoreGraphics

class CircumferencePoint {
    
    var point: CGPoint
    var radius: CGFloat = 0.0
    var degree: CGFloat = 0.0
    
    init(point: CGPoint, radius: CGFloat, degree: CGFloat) {
        self.point = point
        self.radius = radius
        self.degree = degree
    }
}
