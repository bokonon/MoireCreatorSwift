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
    
    // TYPE_ORIGINAL
    let typeOriginal: Int = 3
    
    var currentLine: Int = 0
    
    var moveCount: Int = 0
    
    var timer: NSTimer!
    
    var isFirstFlg: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController viewDidLoad")
        
        self.initUserDefault()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController viewWillAppear")
        
        // automaticaly update view
        timer = nil
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController viewDidAppear")
        
        // only first time called
        if isFirstFlg {
            moireView.updateView()
            isFirstFlg = false
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController viewWillDisappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController viewDidDisappear")
        
        if timer.valid == true {
            timer.invalidate()
            timer = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("ViewController touchesBegan")
        
        moveCount = 0
        
//        let touch = touches.first!
//        let firstPoint = touch.locationInView(moireView)
        
        let touchEvent = touches.first!
        let firstPoint: CGPoint = touchEvent.previousLocationInView(moireView)
        
        moireView.setTouchingMode(currentLine, isTouching: true, firstPoint: firstPoint)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("ViewController touchesMoved")
        
        moveCount++
        print("moveCount", moveCount)
        
        if(moireView.moireType == typeOriginal) {
//            let touch = touches.first!
//            let movePoint = touch.locationInView(moireView)
            
            let touchEvent = touches.first!
            let movePoint: CGPoint = touchEvent.previousLocationInView(moireView)
            
            moireView.touchOriginalMove(currentLine, movePoint: movePoint)
        }
        else {
            let touchEvent = touches.first!
            
            let preDx = touchEvent.previousLocationInView(moireView).x
            let preDy = touchEvent.previousLocationInView(moireView).y
            
            let newDx = touchEvent.locationInView(moireView).x
            let newDy = touchEvent.locationInView(moireView).y
            
            let dx = newDx - preDx
            print("x:\(dx)")
            
            let dy = newDy - preDy
            print("y:\(dy)")
            
            moireView.touchMove(currentLine, dx: dx, dy: dy)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("ViewController touchesEnded")
        
        let touch = touches.first!
        let endPoint = touch.locationInView(moireView)
        
//        let touchEvent = touches.first!
//        let endPoint: CGPoint = touchEvent.previousLocationInView(self.view)
        
        moireView.setTouchingMode(currentLine, isTouching: false, firstPoint: endPoint)
    }
    
    // when go to color picker screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segue_for_setting") {
            let settingView : SettingViewController = segue.destinationViewController as! SettingViewController
            settingView.delegate = self
        }
    }
    
    func update() {
        moireView.setNeedsDisplay()
    }
    
    // setting screen end
    func settingDidFinished() {
        print("ViewController settingDidFinished")
        
        moireView.updateView()
    }
    
    // line a button click
    @IBAction func aButtonClicked(sender: AnyObject) {
        if(currentLine == lineB) {
            currentLine = lineA
            if let image = UIImage(named: "lineA_on.png") {
                lineAButton.setBackgroundImage(image, forState: .Normal)
            }
            if let image = UIImage(named: "lineB_off.png") {
                lineBButton.setBackgroundImage(image, forState: .Normal)
            }
        }
    }
    
    // line b button click
    @IBAction func bButtonClicked(sender: AnyObject) {
        if(currentLine == lineA) {
            currentLine = lineB
            if let image = UIImage(named: "lineB_on.png") {
                lineBButton.setBackgroundImage(image, forState: .Normal)
            }
            if let image = UIImage(named: "lineA_off.png") {
                lineAButton.setBackgroundImage(image, forState: .Normal)
            }
        }
    }
    
    // play button click
    @IBAction func playButtonClicked(sender: AnyObject) {
        if(moireView.getOnPause()) {
            if let image = UIImage(named: "stop.png") {
                playButton.setBackgroundImage(image, forState: .Normal)
                moireView.setOnpause(false)
            }
        }
        else {
            if let image = UIImage(named: "play.png") {
                playButton.setBackgroundImage(image, forState: .Normal)
                moireView.setOnpause(true)
            }
        }
        
    }
    
    // capture button click
    @IBAction func captureButtonClicked(sender: AnyObject) {
        if(moireView != nil) {
            let image = moireView.getCapture()
            
            UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        if error != nil {
            print(error.code)
        }
    }
    
    func initUserDefault() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.registerDefaults(["lineANumber": 50])
        userDefault.registerDefaults(["lineBNumber": 50])
        userDefault.registerDefaults(["lineAThick": 1])
        userDefault.registerDefaults(["lineBThick": 1])
        userDefault.registerDefaults(["lineASlope": 10])
        userDefault.registerDefaults(["lineBSlope": 10])
    }
}

