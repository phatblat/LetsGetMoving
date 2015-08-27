//
//  ActivityViewController.swift
//  LetsGetMoving
//
//  Created by Ben Chatelain on 8/16/15.
//  Copyright © 2015 Ben Chatelain. All rights reserved.
//

import CoreMotion
import UIKit

class ActivityViewController: UIViewController {

    let activityManager = CMMotionActivityManager()

    @IBOutlet var activityLabel: UILabel!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        activityManager.stopActivityUpdates()
    }

    // MARK: - IBAction

    @IBAction func startActivityManager(sender: AnyObject) {
        activityManager.startActivityUpdatesToQueue(NSOperationQueue.mainQueue()) {
            [weak self] (activity: CMMotionActivity?) -> Void in

            var activityString = ""

            if let activity = activity {
                switch activity {
                case activity.automotive == true:
                    activityString = "driving with confidence of \(activity.confidence)"
                case activity.cycling == true:
                    activityString = "cycling with confidence of \(activity.confidence)"
                case activity.running == true:
                    activityString = "running with confidence of \(activity.confidence)"
                case activity.walking == true:
                    activityString = "walking with confidence of \(activity.confidence)"
                case activity.stationary == true:
                    activityString = "stationary with confidence of \(activity.confidence)"
                case activity.unknown == true:
                    activityString = "unknown with confidence of \(activity.confidence)"
                default:
                    activityString = ""
                }

                debugPrint(activityString)

                self?.activityLabel.text = activityString
            }
        }
    }

    @IBAction func stopActivityManager() {
        activityManager.stopActivityUpdates()
        activityLabel.text = "Not currently reading updates."
    }
}
