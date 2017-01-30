//
//  CustomLabel.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/12/05.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    override func drawTextInRect(rect: CGRect) {
        let shadowOffset = self.shadowOffset
        
        let c = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(c, 1)
        CGContextSetLineJoin(c, CGLineJoin.Round)
        
        CGContextSetTextDrawingMode(c, CGTextDrawingMode.Stroke)
        self.textColor = UIColor.blackColor()
        super.drawTextInRect(rect)
        
        CGContextSetTextDrawingMode(c, CGTextDrawingMode.Fill)
        
        self.textColor = UIColor.whiteColor()
        self.shadowOffset = CGSize(width: 0, height: 0)
        super.drawTextInRect(rect)
        
        self.shadowOffset = shadowOffset
    }
}