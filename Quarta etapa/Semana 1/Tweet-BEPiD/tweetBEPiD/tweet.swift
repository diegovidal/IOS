//
//  tweet.swift
//  demo2-testes-bepid
//
//  Created by Eliezio Neto on 19/05/15.
//  Copyright (c) 2015 LearnToProgram.tv. All rights reserved.
//

import UIKit

class tweet: NSObject {
    
    var id : Int
    var message : String
    var timestamp : String
    
    init( id: Int, message: String, timestamp: String){
        self.id = id
        self.message = message
        self.timestamp = timestamp
    }
    
}
