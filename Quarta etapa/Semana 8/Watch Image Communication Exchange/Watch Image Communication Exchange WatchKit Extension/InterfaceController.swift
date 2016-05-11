//
//  InterfaceController.swift
//  Watch Image Communication Exchange WatchKit Extension
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 07/07/15.
//  Copyright (c) 2015 bepid. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    //let appGroupID = "group.br.com.bepid.Watch-Image-Communication-Exchange"
    //let defaults = NSUserDefaults(suiteName: "group.br.com.bepid.Watch-Image-Communication-Exchange")
    let group = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.br.com.bepid.Watch-Image-Communication-Exchange")
    @IBOutlet weak var image: WKInterfaceImage!
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

    @IBAction func loadImage() {
        if let group = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.br.com.bepid.Watch-Image-Communication-Exchange")?.relativePath {
            let path = group.stringByAppendingPathComponent("Library").stringByAppendingPathComponent("Image")
            if let myEncodedImageData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? NSData {
                let imageIOS = UIImage(data: myEncodedImageData)
                image.setImage(imageIOS)
            }

        }

    }
}
