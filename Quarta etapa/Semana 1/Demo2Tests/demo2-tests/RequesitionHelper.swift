//
//  RequesitionHelper.swift
//  demo2-tests
//
//  Created by Diego Vidal on 19/05/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

public let kTwitterURL = "http://webdemo-itunesu.rhcloud.com/users/1/tweets"

class RequesitionHelper: NSObject {
   
    class func loadTweets() -> [Tweet]? {
        let url = NSURL(string: kTwitterURL)
        
        var error: NSError? = nil
        let request = NSURLRequest(URL: url!)
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: &error)
        
        if let data = data {
            
        
            let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &error) as? [NSDictionary]
        
            if let json = json{
                var tweets = [Tweet]()
                for tweetDictionary in json{
                    let id = tweetDictionary["id"] as? Int
                    let message = tweetDictionary["message"] as? String
                    let timestamp = tweetDictionary["timestamp"] as? String
                    
                    if let id = id, message = message, timestamp = timestamp{
                        let tweet = Tweet(id: id, message: message, timestamp: timestamp)
                        tweets.append(tweet)
                    } else{
                        return nil
                }
                    
            }
                
                return tweets
            }
        }
        
        return nil
    }
    
}
