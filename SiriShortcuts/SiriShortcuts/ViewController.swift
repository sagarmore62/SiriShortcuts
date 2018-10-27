//
//  ViewController.swift
//  SiriShortcuts
//
//  Created by Sagar More on 26/10/18.
//  Copyright © 2018 Sagar More. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    static var siriIdentifier : String = {
        return  Bundle.main.bundleIdentifier ?? "com.sagarmore.SiriShortcuts"
    }()
    
    private let userKey = "userDataKey"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupIntents()
    }
    
    //setup the Siri intent to donate
    func setupIntents() {
        //set activityType, which is defined in Info.plist file
        let activity = NSUserActivity(activityType: ViewController.siriIdentifier)
        activity.title = "My Siri Shortcut"
        //dictionary containing app-specific state information needed to continue an activity on another device.
        activity.userInfo = [userKey : "Hey there! You came here through Siri Shortcut."]
        // properties allow iOS to search and suggest our NSUserActivity on the device.
        activity.isEligibleForSearch = true
        if #available(iOS 12.0, *) {
            //Siri can suggest the user activity as a shortcut to the user
            activity.isEligibleForPrediction = true
            activity.persistentIdentifier = NSUserActivityPersistentIdentifier(ViewController.siriIdentifier)
            //activity.suggestedInvocationPhrase = "Try this furniture?"
        } else {
            // Fallback on earlier versions
        }
        //donate shortcut
        view.userActivity = activity
        activity.becomeCurrent()
    }
    
    //show alert
    func showAlert(_ userInfo :  [AnyHashable : Any]?) {
        guard let userMessage = userInfo?[userKey] as? String else {
            return
        }
        let alert = UIAlertController(title: "Siri Shortcut", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

