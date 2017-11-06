//
//  ViewControllerPresenter.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/04.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerPresenter {
    
    let userDefaultsUseCase: UserDefaultsUseCase = UserDefaultsUseCase()
    let savePhotosAlbumUseCase: SavePhotosAlbumUseCase = SavePhotosAlbumUseCase()
    
    func initUserDefaults() {
        userDefaultsUseCase.initUserDefaults()
    }
    
    func getType() -> Int {
        return userDefaultsUseCase.getType()
    }
    
    func getLineAColor() -> UIColor {
        return userDefaultsUseCase.getLineAColor()
    }
    
    func getLineBColor() -> UIColor {
        return userDefaultsUseCase.getLineBColor()
    }
    
    func getBackgroundColor() -> UIColor {
        return userDefaultsUseCase.getBackgroundColor()
    }
    
    func getLineANumber() -> Int {
        return userDefaultsUseCase.getLineANumber()
    }
    
    func getLineBNumber() -> Int {
        return userDefaultsUseCase.getLineBNumber()
    }
    
    func getLineAThick() -> Int {
        return userDefaultsUseCase.getLineAThick()
    }
    
    func getLineBThick() -> Int {
        return userDefaultsUseCase.getLineBThick()
    }
    
    func getLineASlope() -> Int {
        return userDefaultsUseCase.getLineASlope()
    }
    
    func getLineBSlope() -> Int {
        return userDefaultsUseCase.getLineBSlope()
    }
    
    func savePhotosAlbum(image: UIImage, delegate: SavePhotosAlbumDelegate) {
        savePhotosAlbumUseCase.save(image: image, delegate: delegate)
    }
}
