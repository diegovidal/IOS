//
//  SubEventClient.swift
//  EventCast
//
//  Created by Lucas Eduardo on 13/11/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import Alamofire

struct SubEventClient {
    
    
    /**
     Load all sub events of a event for he local phone user
     */
    static func loadSubEventsOfEvent(event: Event, responseBlock: (events: [SubEvent]?, error: NSError?) -> Void) {
        Alamofire.request(.GET, "\(Config.Client.baseURL)/api/v1/event/\(event.identifier)/sub_events", parameters: ["phoneUser": PhoneUser.identifier!])
            .responseCollection { (response: Response<[SubEvent], NSError>) in
                responseBlock(events: response.result.value, error: response.result.error)
        }
    }
    
    
    /**
     Create a new subEvent with the given params
     */
    static func createSubEvent(subEvent: SubEvent,
        responseBlock: (subEvent: SubEvent?, error: NSError?) -> Void) {
            
            let params = ["sub_event": subEvent.toJson()]
            Alamofire.request(.POST, "\(Config.Client.baseURL)/api/v1/sub_event/", parameters: params)
                .responseObject { (response: Response<SubEvent, NSError>) in
                    responseBlock(subEvent: response.result.value, error: response.result.error)
            }
    }
    
    
    /**
     Delete a subEvent created by the event creator.
     */
    static func deleteSubEvent(subEvent: SubEvent, responseBlock:(subEvent: SubEvent?, error: NSError?) -> Void) {
        Alamofire.request(.DELETE, "\(Config.Client.baseURL)/api/v1/sub_event/\(subEvent.identifier)", parameters: nil)
            .customResponseJSON { response  in
                responseBlock(subEvent: subEvent, error: response.result.error)
        }
    }
}