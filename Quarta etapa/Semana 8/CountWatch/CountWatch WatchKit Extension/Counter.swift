//
//  Counter.swift
//  CountWatch
//
//  Created by Edivando Alves on 7/6/15.
//  Copyright (c) 2015 J7ss. All rights reserved.
//

import UIKit

class Counter: NSObject {
    
    private (set) var count = 0
    
    func save(){
        NSUserDefaults.standardUserDefaults().setInteger(count, forKey: "counter")
    }
    
    func retrieve(){
        count = NSUserDefaults.standardUserDefaults().integerForKey("counter")
    }
    
    func increase(){
        count++
        save()
    }
    
    func erase(){
        count = 0
        save()
    }
   
}
