//
//  AboutViewController.swift
//  MoireCreator
//
//  Created by yuji shimada on 2015/11/22.
//  Copyright © 2015年 yuji shimada. All rights reserved.
//

import UIKit
import CoreMotion

class AboutViewController: UIViewController {
    
    @IBOutlet weak var aboutView: UIAboutView!
    // create instance of MotionManager
    let motionManager: CMMotionManager = CMMotionManager()
    
    // override method
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AboutViewController viewDidLoad")
        
        motionManager.deviceMotionUpdateInterval = 0.1 // 20Hz
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("AboutViewController viewWillAppear")
        
        // Start motion data acquisition
        motionManager.startDeviceMotionUpdates( to: OperationQueue.current!, withHandler:{
            deviceManager, error in
            
            // accelerate
            //            let accel: CMAcceleration = deviceManager!.userAcceleration
            //            self.update(accel.x, ry: accel.y)
            //            print("x", accel.x)
            //            print("y", accel.y)
            //            print("z", accel.z)
            
            // rotate
            //            let rx: Double = deviceManager!.rotationRate.x
            //            let ry: Double = deviceManager!.rotationRate.y
            //            let rz: Double = deviceManager!.rotationRate.z
            
            // gravity
            let rx: Double = deviceManager!.gravity.x
            let ry: Double = deviceManager!.gravity.y
            //            let rz: Double = deviceManager!.gravity.z
            
            self.update(rx, ry: ry)
            
                        print("val x", rx)
                        print("val y", ry)
            //            print("val z", rz)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("AboutViewController viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("AboutViewController viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("AboutViewController viewDidDisappear")
        
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update(_ rx: Double, ry: Double) {
        aboutView.move(rx, ry: ry)
        aboutView.checkInFrame()
//        aboutView.setNeedsDisplay()
    }

}
