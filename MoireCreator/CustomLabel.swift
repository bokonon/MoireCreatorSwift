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
  
  override func drawText(in rect: CGRect) {
    let shadowOffset = self.shadowOffset
    
    let c = UIGraphicsGetCurrentContext()
    c?.setLineWidth(1)
    c?.setLineJoin(CGLineJoin.round)
    
    c?.setTextDrawingMode(CGTextDrawingMode.stroke)
    self.textColor = UIColor.black
    super.drawText(in: rect)
    
    c?.setTextDrawingMode(CGTextDrawingMode.fill)
    
    self.textColor = UIColor.white
    self.shadowOffset = CGSize(width: 0, height: 0)
    super.drawText(in: rect)
    
    self.shadowOffset = shadowOffset
  }
}

