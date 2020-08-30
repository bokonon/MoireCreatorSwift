//
//  SavedPhotosAlbumDao.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/11/04.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class SavePhotosAlbumDao: NSObject {
  
  var delegate: SavePhotosAlbumDelegate?
  
  func save(image: UIImage, delegate: SavePhotosAlbumDelegate) {
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
    self.delegate = delegate
  }
  
  @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
    if error != nil {
      delegate?.savePhotosAlbumFailed(error: error)
    }
    else {
      delegate?.savePhotosAlbumComplete()
    }
  }
  
}

