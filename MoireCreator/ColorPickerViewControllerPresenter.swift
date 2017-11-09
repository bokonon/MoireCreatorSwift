//
//  ColorPickerViewControllerPresenter.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/05.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class ColorPickerViewControllerPresenter {
    
    let useCase: ColorPickUseCase = ColorPickUseCase()
    
    func getLineAColor() -> UIColor {
        return useCase.getLineAColor()
    }
    
    func getLineBColor() -> UIColor {
        return useCase.getLineBColor()
    }
    
    func getBackgroundColor() -> UIColor {
        return useCase.getBackgroundColor()
    }
    
    func setLineAColor(colorData: Data) {
        useCase.setLineAColor(colorData: colorData)
    }
    
    func setLineBColor(colorData: Data) {
        useCase.setLineBColor(colorData: colorData)
    }
    
    func setBackgroundColor(colorData: Data) {
        useCase.setBackgroundColor(colorData: colorData)
    }
}
