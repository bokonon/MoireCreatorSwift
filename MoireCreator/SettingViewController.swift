//
//  SettingViewController.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/03.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import UIKit
import GoogleMobileAds

protocol SettingViewControllerDelegate{
    func settingDidFinished()
}

class SettingViewController: UIViewController, UITextFieldDelegate, ColorPickerViewControllerDelegate {
    
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
    
    // override method
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        print("SettingViewController viewDidLoad")
        #endif
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "< MoireView", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingViewController.back(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        self.typeTextField.delegate = self
        
        // AdMob load
        if let apiKey = KeyManager().getValue(key: ApiConstants.admobApiKey) as? String {
            
            print("apiKey : ", apiKey)
            
            bannerView.adUnitID = apiKey
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
        
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        #if DEBUG
        print("SettingViewController viewWillAppear")
        #endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        #if DEBUG
        print("SettingViewController viewDidAppear")
        #endif
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = contentView.frame.size;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // when go to color picker screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        print(segue.identifier as Any)
        
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
    
    // when back
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        #if DEBUG
        print("textFieldShouldReturn")
        #endif
        showTypeAlert()
        return false
    }
    
    func initView() {
        
        // set Type
        let type: Int = presenter.getType()
        switch type {
        case Constants.typeLine:
            self.typeTextField.text = "Line"
        case Constants.typeCircle:
            self.typeTextField.text = "Circle"
        case Constants.typeRect:
            self.typeTextField.text = "Rectangle"
        case Constants.typeHeart:
            self.typeTextField.text = "Heart"
        case Constants.typeSynapse:
            self.typeTextField.text = "Synapse"
        case Constants.typeOriginal:
            self.typeTextField.text = "Original"
        default:
            self.typeTextField.text = "Line"
        }
        
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
    
    func setTypeTextFieldAndDefault(_ type: Int) {
        self.typeTextField.endEditing(true)
        switch type {
        case Constants.typeLine:
            self.typeTextField.text = "Line"
        case Constants.typeCircle:
            self.typeTextField.text = "Circle"
        case Constants.typeRect:
            self.typeTextField.text = "Rectangle"
        case Constants.typeHeart:
            self.typeTextField.text = "Heart"
        case Constants.typeSynapse:
            self.typeTextField.text = "Synapse"
        case Constants.typeOriginal:
            self.typeTextField.text = "Original"
        default:
            self.typeTextField.text = "Line"
        }
        // get userdefault
        let userDefault = UserDefaults.standard
        userDefault.set(type, forKey: "type")
        userDefault.synchronize()
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
        
        let line:UIAlertAction = UIAlertAction(title: "Line",
            style: UIAlertActionStyle.default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.setTypeTextFieldAndDefault(Constants.typeLine)
        })
        
        let circle:UIAlertAction = UIAlertAction(title: "Circle",
            style: UIAlertActionStyle.default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.setTypeTextFieldAndDefault(Constants.typeCircle)
        })
        
        let rect:UIAlertAction = UIAlertAction(title: "Rectangle",
            style: UIAlertActionStyle.default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.setTypeTextFieldAndDefault(Constants.typeRect)
        })
        
        let heart:UIAlertAction = UIAlertAction(title: "Heart",
            style: UIAlertActionStyle.default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.setTypeTextFieldAndDefault(Constants.typeHeart)
        })
        
        let synapse:UIAlertAction = UIAlertAction(title: "Synapse",
            style: UIAlertActionStyle.default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.setTypeTextFieldAndDefault(Constants.typeSynapse)
        })
        
        let original:UIAlertAction = UIAlertAction(title: "Original",
            style: UIAlertActionStyle.default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.setTypeTextFieldAndDefault(Constants.typeOriginal)
        })
        
        alert.addAction(cancelAction)
        alert.addAction(line)
        alert.addAction(circle)
        alert.addAction(rect)
        alert.addAction(heart)
        alert.addAction(synapse)
        alert.addAction(original)
        //        sheet.addAction(destructiveAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // color picker end
    func pickerDidFinished(){
        #if DEBUG
        print("SettingViewController pickerDidFinished")
        #endif
        initView()
    }
    
    @objc func back(_ sender: UIBarButtonItem) {
        presenter.update(lineANumberValue: Int(lineANumberSlider.value), lineBNumberValue: Int(lineBNumberSlider.value),
                         lineAThickValue: Int(lineAThickSlider.value), lineBThickValue: Int(lineBThickSlider.value),
                         lineASlopeValue: Int(lineASlopeSlider.value), lineBSlopeValue: Int(lineBSlopeSlider.value))
        
        self.navigationController?.popViewController(animated: true)
        if(self.delegate != nil) {
            self.delegate.settingDidFinished()
        }
    }

}
