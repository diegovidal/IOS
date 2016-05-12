//
//  EventClient.swift
//  EventCast
//
//  Created by Lucas Eduardo on 27/10/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import Alamofire

struct EventClient {
    
    /** 
     Load all events of the local phone user
     */
    static func loadEvents(responseBlock: (events: [Event]?, error: NSError?) -> Void) {
        //TODO: change this timeZone for the real one
        Alamofire.request(.GET, "\(Config.Client.baseURL)/api/v1/event", parameters: ["phoneUser": PhoneUser.identifier!, "timeZone": "-0300"])
            .responseCollection { (response: Response<[Event], NSError>) in
                responseBlock(events: response.result.value, error: response.result.error)
        }
        
    }
    
    /**
     Checks if the hashtag is available, i.e. there's no event associated with it yet
     */
    static func checkHashtag(hashtag: String, responseBlock: (available: Bool?, error: NSError?) -> Void) {
        Alamofire.request(.GET, "\(Config.Client.baseURL)/api/v1/event/hashtag/check", parameters: ["hashTag": hashtag])
            .customResponseJSON { response in
                if let jsonDict = response.result.value as? [String: AnyObject], let available = jsonDict["available"] as? Bool {
                    responseBlock(available: available, error: response.result.error)
                } else {
                    responseBlock(available: nil, error: response.result.error)
                }
        }
    }
    
    /**
     Associates the local phone user with a specific event, through it's hashtag. In the API V1, this method does not check if the event with the passed hashtag exists, so be sure to pass an already existent one.
     */
    static func followEvent(hashtag: String, responseBlock:(event: Event?, error: NSError?) -> Void) {
        Alamofire.request(.POST, "\(Config.Client.baseURL)/api/v1/event/follow", parameters: ["eventHashcode": hashtag, "phoneUser": PhoneUser.identifier!], encoding: .JSON)
            .responseObject { (response: Response<Event, NSError>) in
                responseBlock(event: response.result.value, error: response.result.error)
        }
        
    }
    
    /**
     Disassociates the local phone user with a specific event, through it's identifier. In the API V1, this method does not check if the event with the passed eventId exists, so be sure to pass an already existent one.
     */
    static func unfollowEvent(event: Event, responseBlock:(event: Event?, error: NSError?) -> Void) {
        Alamofire.request(.POST, "\(Config.Client.baseURL)/api/v1/event/unfollow", parameters: ["eventId": event.identifier, "phoneUser": PhoneUser.identifier!], encoding: .JSON)
            .customResponseJSON { response  in
                responseBlock(event: event, error: response.result.error)
        }
    }
    
    /**
    Creates a new event with a eventName and with a Hashtag. The hashtag is unique, and the API returns "available: false" if the hashtag is already in use.
     */
    static func createEvent(eventName:String, withHashtag hashtag: String, responseBlock:(event: Event?, error: NSError?) -> Void) {
        let eventParams = ["event" : ["name" : eventName, "hashcode" : hashtag, "phoneUser": PhoneUser.identifier!]]
        
        Alamofire.request(.POST, "\(Config.Client.baseURL)/api/v1/event", parameters: eventParams, encoding: .JSON)
            .responseObject { (response: Response<Event, NSError>) in
                responseBlock(event: response.result.value, error: response.result.error)
        }
        
    }

    /**
     Delete a event created by the phone User.
     */
    static func deleteEvent(event: Event, responseBlock:(event: Event?, error: NSError?) -> Void) {
        Alamofire.request(.DELETE, "\(Config.Client.baseURL)/api/v1/event/\(event.identifier)", parameters: nil)
            .customResponseJSON { response  in
                responseBlock(event: event, error: response.result.error)
        }
    }

    /**
     Update status of a specific event in the backend.
    
     event: event to be serialized. It's status property will be sent to server, as true or false.
     */
    static func updateStatusOfEvent(event: Event, responseBlock:(event: Event?, error: NSError?) -> Void) {
        
        let eventJson = event.toJson()
        
        if Config.Alamofire.debugMode {
            debugPrint(eventJson)
        }
        
        Alamofire.request(.POST, "\(Config.Client.baseURL)/api/v1/event/status", parameters: eventJson, encoding: .JSON)
            .customResponseJSON { response  in
                responseBlock(event: event, error: response.result.error)
        }
    }
    
}