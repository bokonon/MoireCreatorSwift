//
//  ViewController.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/01.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingViewControllerDelegate {
    
    // drawing canvas view
    @IBOutlet weak var moireView: UIMoireView!
    
    @IBOutlet weak var lineAButton: UIButton!

    @IBOutlet weak var lineBButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    let lineA: Int = 0
    let lineB: Int = 1
    
    var currentLine: Int = 0
    
    var timer: Timer!
    
    var isFirstFlg: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController viewDidLoad")
        
        self.initUserDefault()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
        print("ViewController viewWillAppear")
        #endif
        
        // automaticaly update view
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        #if DEBUG
        print("ViewController viewDidAppear")
        #endif
        
        // only first time called
        if isFirstFlg {
            moireView.updateView()
            isFirstFlg = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        #if DEBUG
        print("ViewController viewWillDisappear")
        #endif
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        #if DEBUG
        print("ViewController viewDidDisappear")
        #endif
        
        if timer.isValid == true {
            timer.invalidate()
            timer = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        #if DEBUG
        print("ViewController touchesBegan")
        #endif
        
        let touchEvent = touches.first!
        let firstPoint: CGPoint = touchEvent.previousLocation(in: moireView)
        
        moireView.setTouchingMode(currentLine, isTouching: true, firstPoint: firstPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        #if DEBUG
        print("ViewController touchesMoved")
        #endif
        
        if(moireView.moireType == Constants.typeOriginal) {
            let touchEvent = touches.first!
            let movePoint: CGPoint = touchEvent.previousLocation(in: moireView)
            
            moireView.touchOriginalMove(currentLine, movePoint: movePoint)
        }
        else {
            let touchEvent = touches.first!
            
            let preDx = touchEvent.previousLocation(in: moireView).x
            let preDy = touchEvent.previousLocation(in: moireView).y
            
            let newDx = touchEvent.location(in: moireView).x
            let newDy = touchEvent.location(in: moireView).y
            
            let dx = newDx - preDx
            
            #if DEBUG
            print("x:\(dx)")
            #endif
            
            let dy = newDy - preDy
            
            #if DEBUG
            print("y:\(dy)")
            #endif
            
            moireView.touchMove(currentLine, dx: dx, dy: dy)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        #if DEBUG
        print("ViewController touchesEnded")
        #endif
        
        let touch = touches.first!
        let endPoint = touch.location(in: moireView)
        
        moireView.setTouchingMode(currentLine, isTouching: false, firstPoint: endPoint)
    }
    
    // when go to color picker screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "segue_for_setting") {
            let settingView : SettingViewController = segue.destination as! SettingViewController
            settingView.delegate = self
        }
    }
    
    func update() {
        moireView.setNeedsDisplay()
    }
    
    // setting screen end
    func settingDidFinished() {
        #if DEBUG
        print("ViewController settingDidFinished")
        #endif
        
        moireView.updateView()
    }
    
    // line a button click
    @IBAction func aButtonClicked(_ sender: AnyObject) {
        if(currentLine == lineB) {
            currentLine = lineA
            if let image = UIImage(named: "lineA_on.png") {
                lineAButton.setBackgroundImage(image, for: UIControlState())
            }
            if let image = UIImage(named: "lineB_off.png") {
                lineBButton.setBackgroundImage(image, for: UIControlState())
            }
        }
    }
    
    // line b button click
    @IBAction func bButtonClicked(_ sender: AnyObject) {
        if(currentLine == lineA) {
            currentLine = lineB
            if let image = UIImage(named: "lineB_on.png") {
                lineBButton.setBackgroundImage(image, for: UIControlState())
            }
            if let image = UIImage(named: "lineA_off.png") {
                lineAButton.setBackgroundImage(image, for: UIControlState())
            }
        }
    }
    
    // play button click
    @IBAction func playButtonClicked(_ sender: AnyObject) {
        if(moireView.getOnPause()) {
            if let image = UIImage(named: "stop.png") {
                playButton.setBackgroundImage(image, for: UIControlState())
                moireView.setOnpause(false)
            }
        }
        else {
            if let image = UIImage(named: "play.png") {
                playButton.setBackgroundImage(image, for: UIControlState())
                moireView.setOnpause(true)
            }
        }
        
    }
    
    // capture button click
    @IBAction func captureButtonClicked(_ sender: AnyObject) {
        if(moireView != nil) {
            let image = moireView.getCapture()
            
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(ViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        if error != nil {
            print(error.code)
        }
    }
    
    func initUserDefault() {
        let userDefault = UserDefaults.standard
        userDefault.register(defaults: ["lineANumber": 50])
        userDefault.register(defaults: ["lineBNumber": 50])
        userDefault.register(defaults: ["lineAThick": 1])
        userDefault.register(defaults: ["lineBThick": 1])
        userDefault.register(defaults: ["lineASlope": 10])
        userDefault.register(defaults: ["lineBSlope": 10])
    }
}

