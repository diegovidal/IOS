//
//  Constants.swift
//  EventCast
//
//  Created by Lucas Eduardo on 27/10/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import Foundation

struct Config {
    
    //CONSTANTS
    static let keyChainService = NSBundle.mainBundle().bundleIdentifier!
    
    struct PhoneUser {
        static let key = "phoneUser"
    }
    
    struct Client {
        static let baseURL = "http://eventcast-web.herokuapp.com"
    }

    struct Design {
        static let mainColor = UIColor(red: 0.0, green: 65.0/255.0, blue: 139.0/255.0, alpha: 1.0)
    }
    
    //GLOBAL VARS
    struct Alamofire {
        static var debugMode: Bool = false
    }
}