//
//  UserDefaultDao.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/04.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import UIKit
import Foundation

class UserDefaultsDao {
    
    let userDefaults = UserDefaults.standard
    
    func initUserDefaults() {
        userDefaults.register(defaults: [UserDefaultsConstants.lineANumber: 50])
        userDefaults.register(defaults: [UserDefaultsConstants.lineBNumber: 50])
        userDefaults.register(defaults: [UserDefaultsConstants.lineAThick: 1])
        userDefaults.register(defaults: [UserDefaultsConstants.lineBThick: 1])
        userDefaults.register(defaults: [UserDefaultsConstants.lineASlope: 10])
        userDefaults.register(defaults: [UserDefaultsConstants.lineBSlope: 10])
    }
    
    // get
    func getType() -> Int {
        return userDefaults.integer(forKey: UserDefaultsConstants.type)
    }
    
    func getLineAColor() -> UIColor {
        return getUserDefaultColor(defaultName: UserDefaultsConstants.lineAColor)
    }
    
    func getLineBColor() -> UIColor {
        return getUserDefaultColor(defaultName: UserDefaultsConstants.lineBColor)
    }
    
    func getBackgroundColor() -> UIColor {
        return getUserDefaultColor(defaultName: UserDefaultsConstants.backgroundColor)
    }
    
    func getLineANumber() -> Int {
        return userDefaults.integer(forKey: UserDefaultsConstants.lineANumber)
    }
    
    func getLineBNumber() -> Int {
        return userDefaults.integer(forKey: UserDefaultsConstants.lineBNumber)
    }
    
    func getLineAThick() -> Int {
        return userDefaults.integer(forKey: UserDefaultsConstants.lineAThick)
    }
    
    func getLineBThick() -> Int {
        return userDefaults.integer(forKey: UserDefaultsConstants.lineBThick)
    }
    
    func getLineASlope() -> Int {
        return userDefaults.integer(forKey: UserDefaultsConstants.lineASlope)
    }
    
    func getLineBSlope() -> Int {
        return userDefaults.integer(forKey: UserDefaultsConstants.lineBSlope)
    }
    
    // set
    func setType(type: Int) {
        userDefaults.set(type, forKey: UserDefaultsConstants.type)
    }
    
    func setLineAColor(colorData: Data) {
        userDefaults.set(colorData, forKey: UserDefaultsConstants.lineAColor)
    }
    
    func setLineBColor(colorData: Data) {
        userDefaults.set(colorData, forKey: UserDefaultsConstants.lineBColor)
    }
    
    func setBackgroundColor(colorData: Data) {
        userDefaults.set(colorData, forKey: UserDefaultsConstants.backgroundColor)
    }
    
    func update(lineANumberValue: Int, lineBNumberValue: Int,
                lineAThickValue: Int, lineBThickValue: Int,
                lineASlopeValue: Int, lineBSlopeValue: Int) {
        // number
        userDefaults.set(lineANumberValue, forKey: UserDefaultsConstants.lineANumber)
        userDefaults.set(lineBNumberValue, forKey: UserDefaultsConstants.lineBNumber)
        // thick
        userDefaults.set(lineAThickValue, forKey: UserDefaultsConstants.lineAThick)
        userDefaults.set(lineBThickValue, forKey: UserDefaultsConstants.lineBThick)
        // slope
        userDefaults.set(lineASlopeValue, forKey: UserDefaultsConstants.lineASlope)
        userDefaults.set(lineBSlopeValue, forKey: UserDefaultsConstants.lineBSlope)
        
        // user deafult synch
        userDefaults.synchronize()
    }
    
    func getUserDefaultColor(defaultName: String) -> UIColor {
        if let colorData  = userDefaults.object(forKey: defaultName) as? Data {
            if let color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor {
                return color
            }
        }
        if(defaultName == UserDefaultsConstants.backgroundColor) {
            return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    
}
