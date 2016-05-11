//
//  DataToReceive.swift
//  SharingDataWatchKit
//
//  Created by Diego Vidal on 07/07/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class DataToReceive: NSObject {

    private (set) var name = ""
    
    func save(){
        
        let defaults = NSUserDefaults(suiteName: "group.SharingDataWatchKit")
        defaults!.setObject(name, forKey: "string")
        defaults!.synchronize()
    }
    
    func retrieve(){
        let defaults = NSUserDefaults(suiteName: "group.SharingDataWatchKit")
        if let s = defaults?.stringForKey("string"){
            name = s
        }
    }
    
    func changeName(string: String){
        name = string
        save()
    }
    
}
