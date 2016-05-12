//
//  AttendanceClient.swift
//  EventCast
//
//  Created by Lucas Eduardo on 12/11/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import Alamofire

struct AttendanceClient {
    
    /**
     Creates a new attendance for a specific SubEvent. This confirms 
     */
    static func createAttendanceForSubEvent(subEvent: SubEvent, responseBlock:(responseObject: AnyObject?, error: NSError?) -> Void) {
        let subscription = subEvent.event.subscription
        let params = ["subscription_id":  subscription.identifier, "sub_event_id": subEvent.identifier]
        
        Alamofire.request(.POST, "\(Config.Client.baseURL)/api/v1/sub_event/\(subEvent.identifier)/attendance", parameters: params, encoding: .JSON)
            .customResponseJSON{ response in
                responseBlock(responseObject: response.result.value, error: response.result.error)
        }
        
    }
    
    /**
     Delete a event created by the phone User.
     */
    static func deleteAttendanceForSubEvent(subEvent: SubEvent, responseBlock:(responseObject: AnyObject?, error: NSError?) -> Void) {
        let subscription = subEvent.event.subscription
        let params = ["subscription_id":  subscription.identifier, "sub_event_id": subEvent.identifier]
        
        Alamofire.request(.DELETE, "\(Config.Client.baseURL)/api/v1/sub_event/\(subEvent.identifier)/attendance", parameters: params)
            .customResponseJSON { response  in
                 responseBlock(responseObject: response.result.value, error: response.result.error)
        }
    }

}
