//
//  UIAboutView.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/23.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import UIKit

class UIAboutView: UIView {
    
    @IBOutlet var chars: Array<UILabel>?
    
    var frameWidth: CGFloat!
    
    var frameHeight: CGFloat!
    
    var topMargin: CGFloat = 0

    // init from story board
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        frameWidth = CGFloat(self.frame.width)
        frameHeight = CGFloat(self.frame.height)
        
        //labels.append()
    }
    
    // init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        frameWidth = CGFloat(self.frame.width)
        frameHeight = CGFloat(self.frame.height)
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
    }
    
//    func setNavigationBarHeight(barHeight: CGFloat) {
//        let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
//        topMargin = statusBarHeight+barHeight
//    }
    
    func move(_ rx: Double, ry: Double) {
        for i in 0..<chars!.count {
            let random: CGFloat = CGFloat(arc4random_uniform(5)+1)
            let randomAddVal: CGFloat = CGFloat(random/5)
            chars![i].frame.origin.x = chars![i].frame.origin.x + CGFloat(rx)*100*randomAddVal
            chars![i].frame.origin.y = chars![i].frame.origin.y + CGFloat(-ry)*100*randomAddVal
            
//            print("random : ", random)
//            print("randomAddVal", randomAddVal)
        }
    }
    
    func checkInFrame() {
        for i in 0..<chars!.count {
            if(chars![i].frame.origin.x < 0) {
                chars![i].frame.origin.x = 0
            }
            else if(frameWidth - chars![i].frame.width < chars![i].frame.origin.x) {
                chars![i].frame.origin.x = frameWidth - chars![i].frame.width
            }
            if(chars![i].frame.origin.y < topMargin) {
                chars![i].frame.origin.y = topMargin
            }
            else if(frameHeight - chars![i].frame.height < chars![i].frame.origin.y) {
                chars![i].frame.origin.y = frameHeight  - chars![i].frame.height
            }
        }
    }
    
}
