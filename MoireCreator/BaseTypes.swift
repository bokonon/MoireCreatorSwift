//
//  BaseTypes.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/01.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class BaseTypes {
    
    let lineA: Int = 0
    let lineB: Int = 1
    
    let maxLines: Int = 50
    
    let autoSpeed: Float = 0.7
    
    var number: Int = 50
    
    var thick: Int = 1
    
    var slope: Int = 0
    
    var dx: CGFloat = 0.7
    
    var color: UIColor!
    
    init(number: Int) {
        self.number = number
    }
    
    func checkOutOfRange(_ frameWidth :Int) {
        
    }
    
    func move(_ whichLine :Int) {
        
    }
    
    func touchMove(_ dx: CGFloat, dy: CGFloat) {
        
    }
    
    func draw() {
        color.setStroke()
    }
    
    func setColor(_ color: UIColor) {
        self.color = color
    }
    
    func setThick(_ thick: Int) {
        self.thick = thick
    }
    
//    func setSlope(slope: Int) {
//        self.slope = slope
//    }
    
}
