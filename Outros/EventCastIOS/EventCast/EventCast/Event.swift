//
//  Event.swift
//  EventCast
//
//  Created by Lucas Eduardo on 27/10/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import Foundation
import CoreData


final class Event: CoreDataModel, CoreDataActiveRecord {
    
    @NSManaged var hashCode: String
    @NSManaged var name: String
    @NSManaged var phoneUser: String
    @NSManaged var status: Bool
    @NSManaged var subscribersCount: NSNumber
    @NSManaged var subEvents: Set<SubEvent>
    @NSManaged var subscription: Subscription

    var isOwner: Bool {
        return phoneUser == PhoneUser.identifier!
    }
    
    func toJson() -> [String: AnyObject] {
        var json = [String: AnyObject]()
        json["id"] = identifier
        json["name"] = name
        json["status"] = status
        json["hashCode"] = hashCode
        json["phoneUser"] = phoneUser
        
        return json
    }
}



//MARK: - Event Serializer
extension Event: ResponseSerializable {
    
    class var keyPath: String? {
        return "events"
    }
    
    class func build(response response: NSHTTPURLResponse, representation: AnyObject) throws -> Event {
        
        //case when trying to create an event with a already existent hashtag
        guard (representation.valueForKeyPath("available") == nil) else {
            throw BuildError.ValidationError(message: NSLocalizedString("event_not_available", comment: "Validation error messaege to be shown when trying to create a new event"))
        }
        
        let event = Event(temporary: true)

        //single properties
        event.identifier = (representation.valueForKeyPath("id") as? NSNumber)?.stringValue ?? ""
        event.name = (representation.valueForKeyPath("name") as? String) ?? ""
        event.hashCode = (representation.valueForKeyPath("hashCode") as? String) ?? ""
        event.phoneUser = (representation.valueForKeyPath("phoneUser") as? String) ?? ""
        event.subscribersCount = (representation.valueForKeyPath("subscribersCount") as? NSNumber) ?? 0
        event.status = (representation.valueForKeyPath("status") as? NSNumber)?.boolValue ?? true
        
        
        //relationships
        let subEventsJson = (representation.valueForKeyPath("subEventsList") as? [[String : AnyObject]]) ?? []
        let subEvents = subEventsJson.map { (subEventJson) -> SubEvent in
            return try! SubEvent.build(response: response, representation: subEventJson)
        }
        event.subEvents = Set(subEvents)
        
        if let subscriptionJson = (representation.valueForKeyPath("subscription") as? [String : AnyObject]) {
            event.subscription = try! Subscription.build(response: response, representation: subscriptionJson)
        }
        
        
        return event
    }
}