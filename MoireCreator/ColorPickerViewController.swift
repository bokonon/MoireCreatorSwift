//
//  ColorPickerViewController.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/08.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import UIKit

protocol ColorPickerViewControllerDelegate{
  func pickerDidFinished()
}

class ColorPickerViewController: UIViewController {
  
  var delegate: ColorPickerViewControllerDelegate! = nil
  
  // LINE_A
  let lineA: Int = 0
  // LINE_B
  let lineB: Int = 1
  // Background
  let background: Int = 2
  
  // color category
  var colorCategory: Int = 0
  // title
  @IBOutlet weak var categoryTitle: UILabel!
  
  // slider red
  @IBOutlet weak var sliderRed: UISlider!
  // slider green
  @IBOutlet weak var sliderGreen: UISlider!
  // slider blue
  @IBOutlet weak var sliderBlue: UISlider!
  // slider alpha
  @IBOutlet weak var sliderAlpha: UISlider!
  // preview
  @IBOutlet weak var previewColor: UIView!
  
  let presenter: ColorPickerViewControllerPresenter = ColorPickerViewControllerPresenter()
  
  // override method
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // for get ARGB
    var red: CGFloat     = 1.0
    var green: CGFloat   = 1.0
    var blue: CGFloat    = 1.0
    var alpha: CGFloat   = 1.0
    
    switch colorCategory {
    case lineA:
      self.categoryTitle.text = "Line A"
      // get LineA preview color
      let lineAColor = presenter.getLineAColor()
      lineAColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
      break
    case lineB:
      self.categoryTitle.text = "Line B"
      // get LineB preview color
      let lineBColor = presenter.getLineBColor()
      lineBColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
      break
    case background:
      self.categoryTitle.text = "Background"
      // get background preview color
      let backgroundColor = presenter.getBackgroundColor()
      backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
      break
    default: break
      
    }
    
    sliderRed.setValue(Float(red), animated: true)
    sliderGreen.setValue(Float(green), animated: true)
    sliderBlue.setValue(Float(blue), animated: true)
    sliderAlpha.setValue(Float(alpha), animated: true)
    
    updatePreviewColor()
  }
  
  override func viewWillDisappear(_ animated : Bool) {
    super.viewWillDisappear(animated)
    
    if self.isMovingFromParentViewController {
      // save to userdefault
      saveToUserDefault()
      if(self.delegate != nil){
        // call delegate method
        self.delegate.pickerDidFinished()
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func sliderRedChanged(_ sender: AnyObject) {
    updatePreviewColor()
  }
  
  @IBAction func sliderGreenChanged(_ sender: AnyObject) {
    updatePreviewColor()
  }
  
  @IBAction func sliderBlueChanged(_ sender: AnyObject) {
    updatePreviewColor()
  }
  
  @IBAction func sliderAlphaChanged(_ sender: AnyObject) {
    updatePreviewColor()
  }
  
  func updatePreviewColor() {
    previewColor.backgroundColor = getUIColor()
  }
  
  func getUIColor() -> (UIColor) {
    return UIColor(red: CGFloat(sliderRed.value), green: CGFloat(sliderGreen.value), blue: CGFloat(sliderBlue.value), alpha: CGFloat(sliderAlpha.value))
  }
  
  func saveToUserDefault() {
    let colorData: Data = NSKeyedArchiver.archivedData(withRootObject: getUIColor())
    // get userdefault
    let userDefault = UserDefaults.standard
    switch colorCategory {
    case lineA:
      presenter.setLineAColor(colorData: colorData)
    case lineB:
      presenter.setLineBColor(colorData: colorData)
    case background:
      presenter.setBackgroundColor(colorData: colorData)
    default: break
      
    }
    userDefault.synchronize()
  }
  
}

