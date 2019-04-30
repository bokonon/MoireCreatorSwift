//
//  ViewController+SettingViewControllerDelegate.swift
//  MoireCreator
//
//  Created by yuji shimada on 4/30/19.
//  Copyright © 2019 yuji shimada. All rights reserved.
//

import UIKit

import Firebase

extension ViewController: SettingViewControllerDelegate {
  
  // setting screen end
  func settingDidFinished() {
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterContentType: "setting did finished"
      ])
    #if DEBUG
    print("ViewController settingDidFinished")
    #endif
    
    updateView()
  }
  
}
