//
//  NotificationController.swift
//  CountWatch WatchKit Extension
//
//  Created by Edivando Alves on 7/6/15.
//  Copyright (c) 2015 J7ss. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {

    @IBOutlet var alertMessage: WKInterfaceLabel!
    @IBOutlet var counterLabel: WKInterfaceLabel!
    
    private let counter = Counter()
    
    override init() {
        // Initialize variables here.
        super.init()
        
        counter.retrieve()
        
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) {
        
        
        println(identifier)
    }

    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a local notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        completionHandler(.Custom)
    }

    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a remote notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        if let remoteAps = remoteNotification["aps"] as? NSDictionary, remoteAlert = remoteAps["alert"] as? NSDictionary{
            alertMessage.setText(remoteAlert["body"] as? String)
        }
        counter.increase()
        counterLabel.setText("\(counter.count)")
        
        
        println(remoteNotification)
        
        completionHandler(.Custom)
    }

}
