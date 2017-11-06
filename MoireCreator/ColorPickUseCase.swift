//
//  ColorPickUseCase.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/05.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation

class ColorPickUseCase {
    
    let dao: UserDefaultsDao = UserDefaultsDao()
    
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
