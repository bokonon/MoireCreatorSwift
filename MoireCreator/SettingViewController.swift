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

class SettingViewController: UIViewController, UITextFieldDelegate, ColorPickerViewControllerDelegate{
    
    var delegate: SettingViewControllerDelegate! = nil
    
    // TYPE_LINE
    let typeLine: Int = 0
    // TYPE_CIRCLE
    let typeCircle: Int = 1
    // TYPE_RECT
    let typeRect: Int = 2
    // TYPE_ORIGINAL
    let typeOriginal: Int = 3
    
    // LINE_A
    let lineA: Int = 0
    // LINE_B
    let lineB: Int = 1
    // Background
    let background: Int = 2
    
    let maxLines: Int = 50
    let maxThick: Int = 20
    let maxSlope: Int = 150
    
//    let heightConstraint = NSLayoutConstraint(item: self.targetView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 0)
    
    var colorCategory: Int = 0
    
    // type text field
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
    
    // override method
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SettingViewController viewDidLoad")
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "< MoireView", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingViewController.back(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        self.typeTextField.delegate = self
        
        // AdMob load
        bannerView.adUnitID = "ca-app-pub-xxxx"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SettingViewController viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SettingViewController viewDidAppear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // when go to color picker screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        print(segue.identifier as Any)
        
        if (segue.identifier == "lineASegue") {
            colorCategory = lineA
        }
        else if(segue.identifier == "lineBSegue") {
            colorCategory = lineB
        }
        else if(segue.identifier == "backgroundSegue") {
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
        print("textFieldShouldReturn")
        showTypeAlert()
        return false
    }
    
    func initView() {
        // get userdefault
        let userDefault = UserDefaults.standard
        
        // set Type
        let type: Int = userDefault.integer(forKey: "type")
        switch type {
        case typeLine:
            self.typeTextField.text = "Line"
        case typeCircle:
            self.typeTextField.text = "Circle"
        case typeRect:
            self.typeTextField.text = "Rectangle"
        case typeOriginal:
            self.typeTextField.text = "Original"
        default:
            self.typeTextField.text = "Line"
        }
        
        // set color
        lineAColorView.backgroundColor = getUserDefaultColor(userDefault, defaultName: "lineAColor")
        lineBColorView.backgroundColor = getUserDefaultColor(userDefault, defaultName: "lineBColor")
        backgroundColorView.backgroundColor = getUserDefaultColor(userDefault, defaultName: "backgroundColor")
        
        // set number
        lineANumberSlider.minimumValue = 10
        lineANumberSlider.maximumValue = Float(maxLines)
        let lineANumberValue: Int = userDefault.integer(forKey: "lineANumber")
        lineANumberSlider.setValue(Float(lineANumberValue), animated: true)
        lineANumberLabel.text = String(lineANumberValue)
        lineBNumberSlider.minimumValue = 10
        lineBNumberSlider.maximumValue = Float(maxLines)
        let lineBNumberValue: Int = userDefault.integer(forKey: "lineBNumber")
        lineBNumberSlider.setValue(Float(lineBNumberValue), animated: true)
        lineBNumberLabel.text = String(lineBNumberValue)
        
        // set thick
        lineAThickSlider.minimumValue = 1
        lineAThickSlider.maximumValue = Float(maxThick)
        let lineAThickValue: Int = userDefault.integer(forKey: "lineAThick")
        lineAThickSlider.setValue(Float(lineAThickValue), animated: true)
        lineAThickLabel.text = String(lineAThickValue)
        lineBThickSlider.minimumValue = 1
        lineBThickSlider.maximumValue = Float(maxThick)
        let lineBThickValue: Int = userDefault.integer(forKey: "lineBThick")
        lineBThickSlider.setValue(Float(lineBThickValue), animated: true)
        lineBThickLabel.text = String(lineBThickValue)
        
        // set slope
        lineASlopeSlider.minimumValue = 0
        lineASlopeSlider.maximumValue = Float(maxSlope)
        let lineASlopeValue: Int = userDefault.integer(forKey: "lineASlope")
        lineASlopeSlider.setValue(Float(lineASlopeValue), animated: true)
        lineASlopeLabel.text = String(lineASlopeValue)
        lineBSlopeSlider.minimumValue = 0
        lineBSlopeSlider.maximumValue = Float(maxSlope)
        let lineBSlopeValue: Int = userDefault.integer(forKey: "lineBSlope")
        lineBSlopeSlider.setValue(Float(lineBSlopeValue), animated: true)
        lineBSlopeLabel.text = String(lineBSlopeValue)
    }
    
    func setTypeTextFieldAndDefault(_ type: Int) {
        self.typeTextField.endEditing(true)
        switch type {
        case typeLine:
            self.typeTextField.text = "Line"
        case typeCircle:
            self.typeTextField.text = "Circle"
        case typeRect:
            self.typeTextField.text = "Rectangle"
        case typeOriginal:
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
                self.setTypeTextFieldAndDefault(self.typeLine)
        })
        
        let circle:UIAlertAction = UIAlertAction(title: "Circle",
            style: UIAlertActionStyle.default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.setTypeTextFieldAndDefault(self.typeCircle)
        })
        
        let rect:UIAlertAction = UIAlertAction(title: "Rectangle",
            style: UIAlertActionStyle.default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.setTypeTextFieldAndDefault(self.typeRect)
        })
        
        let original:UIAlertAction = UIAlertAction(title: "Original",
            style: UIAlertActionStyle.default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.setTypeTextFieldAndDefault(self.typeOriginal)
        })
        
        //        let destructiveAction:UIAlertAction = UIAlertAction(title: "Destructive",
        //            style: UIAlertActionStyle.Destructive,
        //            handler:{
        //                (action:UIAlertAction!) -> Void in
        //                print("Destructive")
        //        })
        
        alert.addAction(cancelAction)
        alert.addAction(line)
        alert.addAction(circle)
        alert.addAction(rect)
        alert.addAction(original)
        //        sheet.addAction(destructiveAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // color picker end
    func pickerDidFinished(){
        print("SettingViewController pickerDidFinished")
        initView()
    }
    
    func back(_ sender: UIBarButtonItem) {
        print("SettingViewController back")
        // save current status
        let userDefault = UserDefaults.standard
        // number
        userDefault.set(Int(lineANumberSlider.value), forKey: "lineANumber")
        userDefault.set(Int(lineBNumberSlider.value), forKey: "lineBNumber")
        // thick
        userDefault.set(Int(lineAThickSlider.value), forKey: "lineAThick")
        userDefault.set(Int(lineBThickSlider.value), forKey: "lineBThick")
        // slope
        userDefault.set(Int(lineASlopeSlider.value), forKey: "lineASlope")
        userDefault.set(Int(lineBSlopeSlider.value), forKey: "lineBSlope")
        
        // user deafult synch
        userDefault.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        if(self.delegate != nil) {
            self.delegate.settingDidFinished()
        }
        print("SettingViewController back")
    }
    
    func getUserDefaultColor(_ userDefault: UserDefaults, defaultName: String) -> UIColor {
        if let colorData  = userDefault.object(forKey: defaultName) as? Data {
            if let color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor {
                return color
            }
        }
        if(defaultName == "backgroundColor") {
            return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }

}
