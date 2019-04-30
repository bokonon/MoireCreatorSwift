//
//  ViewController.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/01.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import UIKit

import Firebase

class ViewController: UIViewController {
  
  // MARK: - Properties -
  
  // drawing canvas view
  @IBOutlet weak var moireView: UIMoireView!
  
  @IBOutlet weak var lineAButton: UIButton!
  
  @IBOutlet weak var lineBButton: UIButton!
  
  @IBOutlet weak var playButton: UIButton!
  
  @IBOutlet weak var captureButton: UIButton!
  
  let lineA: Int = 0
  let lineB: Int = 1
  
  var currentLine: Int = 0
  
  var timer: Timer!
  
  var isFirstFlg: Bool = true
  
  let presenter: ViewControllerPresenter = ViewControllerPresenter()
  
  // MARK: - Life cycle events -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    #if DEBUG
    print("ViewController viewDidLoad")
    #endif
    
    presenter.initUserDefaults()
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
      updateView()
      isFirstFlg = false
    }
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    #if DEBUG
    print("ViewController viewDidDisappear")
    #endif
    
    if let workingTimer = timer {
      workingTimer.invalidate()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Public Method -
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    #if DEBUG
    print("ViewController touchesBegan")
    #endif
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterContentType: "touch began"
      ])
    
    let touchEvent = touches.first!
    let firstPoint: CGPoint = touchEvent.previousLocation(in: moireView)
    
    moireView.setTouchingMode(currentLine, isTouching: true, firstPoint: firstPoint)
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    #if DEBUG
    print("ViewController touchesMoved")
    #endif
    
    if(moireView.moireType == .ORIGINAL) {
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
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterContentType: "touch ended"
      ])
    
    let touch = touches.first!
    let endPoint = touch.location(in: moireView)
    
    moireView.setTouchingMode(currentLine, isTouching: false, firstPoint: endPoint)
  }
  
  // when go to setting screen
  override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
    if segue.identifier == "segue_for_setting" {
      let settingView : SettingViewController = segue.destination as! SettingViewController
      settingView.delegate = self
    }
  }
  
  @objc func update() {
    moireView.setNeedsDisplay()
  }
  
  // line a button click
  @IBAction func aButtonClicked(_ sender: AnyObject) {
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterContentType: "a button"
      ])
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
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterContentType: "b button"
      ])
    if currentLine == lineA {
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
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterContentType: "play button"
      ])
    if moireView.isOnPause() {
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
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterContentType: "capture button"
      ])
    if moireView != nil {
      if let image = UIImage(named: "photo_on.png") {
        captureButton.setBackgroundImage(image, for: UIControlState())
      }
      
      let image = moireView.getCapture()
      presenter.savePhotosAlbum(image: image, delegate: self)
    }
  }
  
  func updateView() {
    let type = presenter.getType()
    let backgroundColor = presenter.getBackgroundColor()
    let lineAColor = presenter.getLineAColor()
    let lineBColor = presenter.getLineBColor()
    let lineANumber = presenter.getLineANumber()
    let lineBNumber = presenter.getLineBNumber()
    let lineAThick = presenter.getLineAThick()
    let lineBThick = presenter.getLineBThick()
    let lineASlope = presenter.getLineASlope()
    let lineBSlope = presenter.getLineBSlope()
    
    moireView.updateView(type: type, backgroundColor: backgroundColor,
                         lineAColor: lineAColor, lineBColor: lineBColor,
                         lineANumber: lineANumber, lineBNumber: lineBNumber,
                         lineAThick: lineAThick, lineBThick: lineBThick,
                         lineASlope: lineASlope, lineBSlope: lineBSlope)
  }
  
  func setCaptureButtonDefault() {
    if let image = UIImage(named: "photo_off.png") {
      captureButton.setBackgroundImage(image, for: UIControlState())
    }
  }
  
  func showAlert(title: String, message: String) {
    let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle:  UIAlertControllerStyle.alert)
    
    let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
      (action: UIAlertAction!) -> Void in
      print("OK")
    })
    
    alert.addAction(defaultAction)
    present(alert, animated: true, completion: nil)
  }
  
  deinit {
    print("ViewController deinit")
  }
  
}
