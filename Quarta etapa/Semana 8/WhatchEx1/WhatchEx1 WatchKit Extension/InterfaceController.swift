//
//  InterfaceController.swift
//  WhatchEx1 WatchKit Extension
//
//  Created by Oton Braga on 06/07/15.
//  Copyright (c) 2015 Othon. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
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
    @IBAction func chico() {
        WKInterfaceController.openParentApplication(["nome": "chico"], reply: { (reply, error) -> Void in
        })
    }

    @IBAction func jose() {
        WKInterfaceController.openParentApplication(["nome": "jose"], reply: { (reply, error) -> Void in
        })
    }

    @IBAction func pedro() {
        WKInterfaceController.openParentApplication(["nome": "pedro"], reply: { (reply, error) -> Void in
        })
    }
}
