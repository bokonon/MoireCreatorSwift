//
//  ColorPickerViewControllerPresenter.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/05.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation

class ColorPickerViewControllerPresenter {
    
    let useCase: ColorPickUseCase = ColorPickUseCase()
    
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
