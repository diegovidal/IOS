//
//  ViewController.swift
//  SharingDataWatchKit
//
//  Created by Diego Vidal on 07/07/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    
    let myString = DataToReceive()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let groupId = "group.SharingDataWatchKit"
//        if let defaults = NSUserDefaults(suiteName: groupId) {
//            myLabel.text = defaults.stringForKey("string")
//        }
        
        myString.retrieve()
        myLabel.text = myString.name
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

