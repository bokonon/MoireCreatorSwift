//
//  UserDefaultsUseCase.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/04.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import UIKit
import Foundation

class UserDefaultsUseCase {
    
    let dao: UserDefaultsDao = UserDefaultsDao()
    
    func initUserDefaults() {
        dao.initUserDefaults()
    }
    
    func setType(type: Type) {
        return dao.setType(type: type)
    }
    
    func update(lineANumberValue: Int, lineBNumberValue: Int,
                lineAThickValue: Int, lineBThickValue: Int,
                lineASlopeValue: Int, lineBSlopeValue: Int) {
        dao.update(lineANumberValue: lineANumberValue, lineBNumberValue: lineBNumberValue,
                   lineAThickValue: lineAThickValue, lineBThickValue: lineBThickValue,
                   lineASlopeValue: lineASlopeValue, lineBSlopeValue: lineBSlopeValue)
    }
    
    func getType() -> Type {
        return dao.getType()
    }
    
    func getLineAColor() -> UIColor {
        return dao.getLineAColor()
    }
    
    func getLineBColor() -> UIColor {
        return dao.getLineBColor()
    }
    
    func getBackgroundColor() -> UIColor {
        return dao.getBackgroundColor()
    }
    
    func getLineANumber() -> Int {
        return dao.getLineANumber()
    }
    
    func getLineBNumber() -> Int {
        return dao.getLineBNumber()
    }
    
    func getLineAThick() -> Int {
        return dao.getLineAThick()
    }
    
    func getLineBThick() -> Int {
        return dao.getLineBThick()
    }
    
    func getLineASlope() -> Int {
        return dao.getLineASlope()
    }
    
    func getLineBSlope() -> Int {
        return dao.getLineBSlope()
    }
    
}
