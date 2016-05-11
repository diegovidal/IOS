//
//  Tweet.swift
//  demo2-tests
//
//  Created by Diego Vidal on 19/05/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class Tweet: NSObject {
   
    var id : Int
    var message : String
    var timestamp : String
    
    init(id: Int, message: String, timestamp: String) {
        self.id = id
        self.message = message;
        self.timestamp = timestamp
    }
    
}
