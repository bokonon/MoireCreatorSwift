//
//  ViewController+SavePhotosAlbumDelegate.swift
//  MoireCreator
//
//  Created by yuji shimada on 4/30/19.
//  Copyright © 2019 yuji shimada. All rights reserved.
//

import UIKit

protocol SavePhotosAlbumDelegate {
  func savePhotosAlbumComplete()
  func savePhotosAlbumFailed(error: NSError)
}

extension ViewController: SavePhotosAlbumDelegate {
  
  func savePhotosAlbumComplete() {
    setCaptureButtonDefault()
  }
  
  func savePhotosAlbumFailed(error: NSError) {
    setCaptureButtonDefault()
    showAlert(title: "Error", message: "Capture saving failed.")
  }
  
}
