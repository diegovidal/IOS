//
//  SubEvent.swift
//  EventCast
//
//  Created by Lucas Eduardo on 11/11/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import UIKit
import CoreData
import AFDateHelper

final class SubEvent: CoreDataModel, CoreDataActiveRecord {
    
    @NSManaged var name: String
    @NSManaged var local: String
    @NSManaged var notes: String
    @NSManaged var startDate: NSDate
    @NSManaged var attendance: Bool
    
    @NSManaged var event: Event
    
    
    func toJson() -> [String: AnyObject] {
        var json = [String: AnyObject]()
        json["id"] = identifier
        json["name"] = name
        json["locurl"] = local
        json["startdatetime"] = startDate.toString(format: .Custom("dd/MM/yyyy HH:mm:ss Z"))
        json["notes"] = notes
        json["event"] = ["id": event.identifier]
        
        return json
    }
    
    convenience init(name: String, startDate: NSDate, local: String, notes: String, event: Event) {
        self.init()
        
        self.name = name
        self.startDate = startDate
        self.local = local
        self.notes = notes
        self.event = event
        self.attendance = true
    }
}

extension SubEvent: ResponseSerializable {
    
    class var keyPath: String? {
        return "sub_events"
    }
    
    class func build(response response: NSHTTPURLResponse, representation: AnyObject) throws -> SubEvent {
        
        let subEvent = SubEvent(temporary: true)
        
        //properties
        subEvent.identifier = (representation.valueForKeyPath("id") as? NSNumber)?.stringValue ?? ""
        subEvent.name = (representation.valueForKeyPath("name") as? String) ?? ""
        subEvent.local = (representation.valueForKeyPath("locurl") as? String) ?? ""
        subEvent.notes = (representation.valueForKeyPath("notes") as? String) ?? ""
        
        let dateString = (representation.valueForKeyPath("startdatetimeutc") as? String) ?? ""
        subEvent.startDate = NSDate(fromString: dateString, format: .Custom("dd/MM/yyyy HH:mm:ss Z"))
        
        subEvent.attendance = (representation.valueForKeyPath("attendance") as? NSString)?.boolValue ?? false
        
        //relationships
        if let eventJson = representation.valueForKeyPath("event") as? [String : AnyObject]
//            ,let identifier = eventJson["id"] as? NSNumber,
//            let event = Event.findByIdentifier(identifier.stringValue)  {
//                subEvent.event = event
        {
            subEvent.event = try! Event.build(response: response, representation: eventJson)
        
        }
        
        return subEvent
    }
}