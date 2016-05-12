//
//  Subscription.swift
//  EventCast
//
//  Created by Lucas Eduardo on 12/11/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import UIKit
import CoreData

final class Subscription: CoreDataModel, CoreDataActiveRecord {
    
    @NSManaged var confirmed: Bool
}

extension Subscription: ResponseSerializable {
    
    class func build(response response: NSHTTPURLResponse, representation: AnyObject) throws -> Subscription {
        
        let subscription = Subscription(temporary: true)
        
        subscription.identifier = (representation.valueForKeyPath("id") as? NSNumber)?.stringValue ?? ""
        subscription.confirmed = (representation.valueForKeyPath("confirmed") as? NSNumber)?.boolValue ?? false
        
        return subscription
    }
}