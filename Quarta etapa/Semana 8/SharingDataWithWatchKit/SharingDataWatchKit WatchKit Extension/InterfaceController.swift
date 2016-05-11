//
//  InterfaceController.swift
//  SharingDataWatchKit WatchKit Extension
//
//  Created by Diego Vidal on 07/07/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    let myString = DataToShare()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        myString.retrieve()
        
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

    @IBAction func diegoButton() {
        myString.changeName("Diego")
    }
}
