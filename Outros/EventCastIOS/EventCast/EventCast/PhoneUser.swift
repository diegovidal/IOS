//
//  PhoneUser.swift
//  EventCast
//
//  Created by Lucas Eduardo on 27/10/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import Foundation
import KeychainAccess

class PhoneUser {
    
    class var identifier: String? {
        let keychain = Keychain(service: Config.keyChainService)
        return keychain[string: Config.PhoneUser.key]
    }
    
    class func createPhoneUser() {
        let keychain = Keychain(service: Config.keyChainService)
        keychain[string: Config.PhoneUser.key] = NSUUID().UUIDString
        print("phoneUser = '\(keychain[string: "phoneUser"])' created with success.")
    }
    
    class func reset() {
        let keychain = Keychain(service: Config.keyChainService)
        keychain[string: Config.PhoneUser.key] = nil
    }
}
