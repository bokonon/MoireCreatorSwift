//
//  CustomButton.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/14.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton {
    
    // courner radius
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    // border
    @IBInspectable var borderColor: UIColor = UIColor.clear
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        
        // courner radius
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)
        
        // border line
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        
        super.draw(rect)
    }
}
