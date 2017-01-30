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
    
    
    // override method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        // get userdefault
        let userDefault = NSUserDefaults.standardUserDefaults()
        
        // for get ARGB
        var red: CGFloat     = 1.0
        var green: CGFloat   = 1.0
        var blue: CGFloat    = 1.0
        var alpha: CGFloat   = 1.0
        
        switch colorCategory {
        case lineA:
            self.categoryTitle.text = "Line A"
            // get LineA preview color
            if let lineAColorData  = userDefault.objectForKey("lineAColor") as? NSData {
                if let lineAColor = NSKeyedUnarchiver.unarchiveObjectWithData(lineAColorData) as? UIColor {
                    lineAColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                    break
                }
            }
            UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        case lineB:
            self.categoryTitle.text = "Line B"
            // get LineB preview color
            if let lineBColorData  = userDefault.objectForKey("lineBColor") as? NSData {
                if let lineBColor = NSKeyedUnarchiver.unarchiveObjectWithData(lineBColorData) as? UIColor {
                    lineBColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                    break
                }
            }
            UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        case background:
            self.categoryTitle.text = "Background"
            // get background preview color
            if let backgroundColorData  = userDefault.objectForKey("backgroundColor") as? NSData {
                if let backgroundColor = NSKeyedUnarchiver.unarchiveObjectWithData(backgroundColorData) as? UIColor {
                    backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                    break
                }
            }
            UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        default: break
            
        }
        
        sliderRed.setValue(Float(red), animated: true)
        sliderGreen.setValue(Float(green), animated: true)
        sliderBlue.setValue(Float(blue), animated: true)
        sliderAlpha.setValue(Float(alpha), animated: true)
        
        updatePreviewColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderRedChanged(sender: AnyObject) {
        updatePreviewColor()
    }
    
    @IBAction func sliderGreenChanged(sender: AnyObject) {
        updatePreviewColor()
    }
    
    @IBAction func sliderBlueChanged(sender: AnyObject) {
        updatePreviewColor()
    }
    
    @IBAction func sliderAlphaChanged(sender: AnyObject) {
        updatePreviewColor()
    }
    
    func updatePreviewColor() {
        previewColor.backgroundColor = getUIColor()
    }
    
    func getUIColor() -> (UIColor) {
        return UIColor(red: CGFloat(sliderRed.value), green: CGFloat(sliderGreen.value), blue: CGFloat(sliderBlue.value), alpha: CGFloat(sliderAlpha.value))
    }
    
    // when back
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func saveToUserDefault() {
        let colorData : NSData = NSKeyedArchiver.archivedDataWithRootObject(getUIColor())
        // get userdefault
        let userDefault = NSUserDefaults.standardUserDefaults()
        switch colorCategory {
        case lineA:
            userDefault.setObject(colorData, forKey: "lineAColor")
        case lineB:
            userDefault.setObject(colorData, forKey: "lineBColor")
        case background:
            userDefault.setObject(colorData, forKey: "backgroundColor")
        default: break
            
        }
        userDefault.synchronize()
    }
    
    func back(sender: UIBarButtonItem) {
        // save to userdefault
        saveToUserDefault()
        if(self.delegate != nil){
            // call delegate method
            self.delegate.pickerDidFinished()
        }
        self.navigationController?.popViewControllerAnimated(true)
        print("ColorPickerViewController back")
    }
    
}
