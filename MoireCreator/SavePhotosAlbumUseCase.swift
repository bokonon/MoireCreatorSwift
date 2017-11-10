//
//  CaptureUseCase.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/04.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class SavePhotosAlbumUseCase {
    
    let dao: SavePhotosAlbumDao = SavePhotosAlbumDao()
    
    func save(image: UIImage, delegate: SavePhotosAlbumDelegate) {
        dao.save(image: image, delegate: delegate)
    }
    
}
