//
//  SettingViewControllerPresenter.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/04.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import UIKit
import Foundation

class SettingViewControllerPresenter {
    
    let useCase: UserDefaultsUseCase = UserDefaultsUseCase()
    
    func setType(type: Int) {
        return useCase.setType(type: type)
    }
    
    func update(lineANumberValue: Int, lineBNumberValue: Int,
                lineAThickValue: Int, lineBThickValue: Int,
                lineASlopeValue: Int, lineBSlopeValue: Int) {
        useCase.update(lineANumberValue: lineANumberValue, lineBNumberValue: lineBNumberValue,
                               lineAThickValue: lineAThickValue, lineBThickValue: lineBThickValue,
                               lineASlopeValue: lineASlopeValue, lineBSlopeValue: lineBSlopeValue)
    }
    
    func getType() -> Int {
        return useCase.getType()
    }
    
    func getLineAColor() -> UIColor {
        return useCase.getLineAColor()
    }
    
    func getLineBColor() -> UIColor {
        return useCase.getLineBColor()
    }
    
    func getBackgroundColor() -> UIColor {
        return useCase.getBackgroundColor()
    }
    
    func getLineANumber() -> Int {
        return useCase.getLineANumber()
    }
    
    func getLineBNumber() -> Int {
        return useCase.getLineBNumber()
    }
    
    func getLineAThick() -> Int {
        return useCase.getLineAThick()
    }
    
    func getLineBThick() -> Int {
        return useCase.getLineBThick()
    }
    
    func getLineASlope() -> Int {
        return useCase.getLineASlope()
    }
    
    func getLineBSlope() -> Int {
        return useCase.getLineBSlope()
    }
    
}
