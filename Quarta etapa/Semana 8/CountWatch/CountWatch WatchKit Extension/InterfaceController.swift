//
//  InterfaceController.swift
//  CountWatch WatchKit Extension
//
//  Created by Edivando Alves on 7/6/15.
//  Copyright (c) 2015 J7ss. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    private let counter = Counter()
    @IBOutlet var countLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        counter.retrieve()
        countLabel.setText("\(counter.count)")
        
        NSUserDefaults.init
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func count() {
        counter.increase()
        countLabel.setText("\(counter.count)")
    }
    
    @IBAction func erase() {
        counter.erase()
        countLabel.setText("\(counter.count)")
    }

}
