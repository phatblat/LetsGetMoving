//
//  DeviceMotionViewController.swift
//  LetsGetMoving
//
//  Created by Ben Chatelain on 8/16/15.
//  Copyright © 2015 Ben Chatelain. All rights reserved.
//

import CoreMotion
import UIKit

class DeviceMotionViewController: UIViewController {

    let motionManager = CMMotionManager()

    @IBOutlet var deviceMotionLabel: UILabel!
    @IBOutlet var deviceMotionTextView: UITextView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        motionManager.deviceMotionUpdateInterval = 2
        motionManager.gyroUpdateInterval = 2
        motionManager.accelerometerUpdateInterval = 2
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        motionManager.stopDeviceMotionUpdates()
    }

    // MARK: - IBAction

    @IBAction func startDeviceMotion(sender: AnyObject) {
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
            [weak self] (motion: CMDeviceMotion?, error: NSError?) -> Void in

            var deviceMotionString = ""

            if let motion = motion, weakSelf = self {
                if weakSelf.motionManager.accelerometerAvailable {
                    deviceMotionString = "Attitude - roll: \(motion.attitude.roll), pitch: \(motion.attitude.pitch), yaw: \(motion.attitude.yaw)"
                    deviceMotionString += "\n\nRotation - x: \(motion.rotationRate.x), y: \(motion.rotationRate.y), z: \(motion.rotationRate.z)"
                    deviceMotionString += "\n\nGravity - x: \(motion.gravity.x), y: \(motion.gravity.y), z:\(motion.gravity.z)"
                    deviceMotionString += "\n\nUser Acceleration - x: \(motion.userAcceleration.x), y: \(motion.userAcceleration.y), z: \(motion.userAcceleration.z)"
                }
                else {
                    deviceMotionString = "No motion detected"
                }
            }

            debugPrint(deviceMotionString)

//            self?.deviceMotionLabel.text = deviceMotionString
            self?.deviceMotionTextView.text = deviceMotionString
        }
    }

    @IBAction func stopDeviceMotion(sender: AnyObject) {
        motionManager.stopDeviceMotionUpdates()
        deviceMotionLabel.text = "Device motion stopped"
    }

}
