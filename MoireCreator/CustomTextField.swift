//
//  CustomTextField.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/07.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
  
  override func caretRect(for position: UITextPosition) -> CGRect {
    return CGRect.zero
  }
}

