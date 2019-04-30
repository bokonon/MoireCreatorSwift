//
//  SettingViewController.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/03.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import UIKit

import Firebase
import GoogleMobileAds

protocol SettingViewControllerDelegate {
  func settingDidFinished()
}

class SettingViewController: UIViewController, UITextFieldDelegate, ColorPickerViewControllerDelegate {
  
  // MARK: - Properties -
  
  var delegate: SettingViewControllerDelegate! = nil
  
  // LINE_A
  let lineA: Int = 0
  // LINE_B
  let lineB: Int = 1
  // Background
  let background: Int = 2
  
  let maxLines: Int = 50
  let maxThick: Int = 20
  let maxSlope: Int = 150
  
  var colorCategory: Int = 0
  
  @IBOutlet weak var scrollView: UIScrollView!
  // type text field
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var typeTextField: UITextField!
  // preview color
  @IBOutlet weak var lineAColorView: UIView!
  @IBOutlet weak var lineBColorView: UIView!
  @IBOutlet weak var backgroundColorView: UIView!
  
  // number
  @IBOutlet weak var lineANumberLabel: UILabel!
  @IBOutlet weak var lineBNumberLabel: UILabel!
  @IBOutlet weak var lineANumberSlider: UISlider!
  @IBOutlet weak var lineBNumberSlider: UISlider!
  
  // thick
  @IBOutlet weak var lineAThickLabel: UILabel!
  @IBOutlet weak var lineBThickLabel: UILabel!
  @IBOutlet weak var lineAThickSlider: UISlider!
  @IBOutlet weak var lineBThickSlider: UISlider!
  
  // slope
  @IBOutlet weak var lineASlopeLabel: UILabel!
  @IBOutlet weak var lineBSlopeLabel: UILabel!
  @IBOutlet weak var lineASlopeSlider: UISlider!
  @IBOutlet weak var lineBSlopeSlider: UISlider!
  
  // AdMob
  @IBOutlet weak var bannerView: GADBannerView!
  
  let presenter: SettingViewControllerPresenter = SettingViewControllerPresenter()
  
  // MARK: - Life cycle events -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    #if DEBUG
    print("SettingViewController viewDidLoad")
    #endif
    
    self.typeTextField.delegate = self
    
    initView()
    
    // AdMob load
    bannerView.adUnitID = ApiConstants.admobUnitID
    bannerView.rootViewController = self
    bannerView.load(GADRequest())
    
  }
  
  override func viewWillDisappear(_ animated : Bool) {
    super.viewWillDisappear(animated)
    
    if self.isMovingFromParentViewController {
      presenter.update(lineANumberValue: Int(lineANumberSlider.value), lineBNumberValue: Int(lineBNumberSlider.value),
                       lineAThickValue: Int(lineAThickSlider.value), lineBThickValue: Int(lineBThickSlider.value),
                       lineASlopeValue: Int(lineASlopeSlider.value), lineBSlopeValue: Int(lineBSlopeSlider.value))
      
      if(self.delegate != nil) {
        self.delegate.settingDidFinished()
      }
    }
  }
  
  override func viewDidLayoutSubviews() {
    scrollView.contentSize = contentView.frame.size;
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Public Method -
  
  // when go to color picker screen
  override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
    #if DEBUG
    print(segue.identifier as Any)
    #endif
    
    if (segue.identifier == "segue_for_line_a_color") {
      colorCategory = lineA
    }
    else if(segue.identifier == "segue_for_line_b_color") {
      colorCategory = lineB
    }
    else if(segue.identifier == "segue_for_line_background_color") {
      colorCategory = background
    }
    let colorPicker : ColorPickerViewController = segue.destination as! ColorPickerViewController
    colorPicker.colorCategory = colorCategory
    
    colorPicker.delegate = self
  }
  
  @IBAction func sliderNumberAChanged(_ sender: UISlider) {
    lineANumberLabel.text = String(Int(sender.value))
  }
  @IBAction func sliderNumberBChanged(_ sender: UISlider) {
    lineBNumberLabel.text = String(Int(sender.value))
  }
  @IBAction func sliderTickAChanged(_ sender: UISlider) {
    lineAThickLabel.text = String(Int(sender.value))
  }
  @IBAction func sliderTickBChanged(_ sender: UISlider) {
    lineBThickLabel.text = String(Int(sender.value))
  }
  @IBAction func sliderSlopeAChanged(_ sender: UISlider) {
    lineASlopeLabel.text = String(Int(sender.value))
  }
  @IBAction func sliderSlopeBChanged(_ sender: UISlider) {
    lineBSlopeLabel.text = String(Int(sender.value))
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterContentType: "type select"
      ])
    #if DEBUG
    print("textFieldShouldReturn")
    #endif
    showTypeAlert()
    return false
  }
  
  func initView() {
    
    // set Type
    let type: Type = presenter.getType()
    self.typeTextField.text = type.description
    
    // set color
    lineAColorView.backgroundColor = presenter.getLineAColor()
    lineBColorView.backgroundColor = presenter.getLineBColor()
    backgroundColorView.backgroundColor = presenter.getBackgroundColor()
    
    // set number
    lineANumberSlider.minimumValue = 10
    lineANumberSlider.maximumValue = Float(maxLines)
    let lineANumberValue: Int = presenter.getLineANumber()
    lineANumberSlider.setValue(Float(lineANumberValue), animated: true)
    lineANumberLabel.text = String(lineANumberValue)
    lineBNumberSlider.minimumValue = 10
    lineBNumberSlider.maximumValue = Float(maxLines)
    let lineBNumberValue: Int = presenter.getLineBNumber()
    lineBNumberSlider.setValue(Float(lineBNumberValue), animated: true)
    lineBNumberLabel.text = String(lineBNumberValue)
    
    // set thick
    lineAThickSlider.minimumValue = 1
    lineAThickSlider.maximumValue = Float(maxThick)
    let lineAThickValue: Int = presenter.getLineAThick()
    lineAThickSlider.setValue(Float(lineAThickValue), animated: true)
    lineAThickLabel.text = String(lineAThickValue)
    lineBThickSlider.minimumValue = 1
    lineBThickSlider.maximumValue = Float(maxThick)
    let lineBThickValue: Int = presenter.getLineBThick()
    lineBThickSlider.setValue(Float(lineBThickValue), animated: true)
    lineBThickLabel.text = String(lineBThickValue)
    
    // set slope
    lineASlopeSlider.minimumValue = 0
    lineASlopeSlider.maximumValue = Float(maxSlope)
    let lineASlopeValue: Int = presenter.getLineASlope()
    lineASlopeSlider.setValue(Float(lineASlopeValue), animated: true)
    lineASlopeLabel.text = String(lineASlopeValue)
    lineBSlopeSlider.minimumValue = 0
    lineBSlopeSlider.maximumValue = Float(maxSlope)
    let lineBSlopeValue: Int = presenter.getLineBSlope()
    lineBSlopeSlider.setValue(Float(lineBSlopeValue), animated: true)
    lineBSlopeLabel.text = String(lineBSlopeValue)
  }
  
  func setTypeTextFieldAndDefault(_ type: Type) {
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterContentType: "type selected",
      "type": type.description
      ])
    self.typeTextField.endEditing(true)
    self.typeTextField.text = type.description
    
    presenter.setType(type: type)
  }
  
  // select Type ActionSheet
  func showTypeAlert() {
    let alert: UIAlertController = UIAlertController(title:"Please select a Type",
                                                     message: "",
                                                     preferredStyle: UIAlertControllerStyle.actionSheet)
    
    let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                   style: UIAlertActionStyle.cancel,
                                                   handler:{
                                                    (action:UIAlertAction!) -> Void in
                                                    print("Cancel")
                                                    self.typeTextField.endEditing(true)
    })
    
    for type in Type.allCases {
      let action:UIAlertAction = UIAlertAction(title: type.description,
                                               style: UIAlertActionStyle.default,
                                               handler:{
                                                (action:UIAlertAction!) -> Void in
                                                self.setTypeTextFieldAndDefault(type)
      })
      alert.addAction(action)
    }
    
    alert.addAction(cancelAction)
    //        sheet.addAction(destructiveAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  // color picker end
  func pickerDidFinished() {
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterContentType: "color picker didfinished"
      ])
    #if DEBUG
    print("SettingViewController pickerDidFinished")
    #endif
    initView()
  }
  
  deinit {
    print("SettingViewController deinit")
  }
  
}

