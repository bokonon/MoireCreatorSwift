//
//  ColorPickUseCase.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/05.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class ColorPickUseCase {
    
    let dao: UserDefaultsDao = UserDefaultsDao()
    
    func getLineAColor() -> UIColor {
        return dao.getLineAColor()
    }
    
    func getLineBColor() -> UIColor {
        return dao.getLineBColor()
    }
    
    func getBackgroundColor() -> UIColor {
        return dao.getBackgroundColor()
    }
    
    func setLineAColor(colorData: Data) {
        return dao.setLineAColor(colorData: colorData)
    }
    
    func setLineBColor(colorData: Data) {
        return dao.setLineBColor(colorData: colorData)
    }
    
    func setBackgroundColor(colorData: Data) {
        return dao.setBackgroundColor(colorData: colorData)
    }
    
}
