//
//  RequisitonHelper.swift
//  demo2-testes-bepid
//
//  Created by Eliezio Neto on 19/05/15.
//  Copyright (c) 2015 LearnToProgram.tv. All rights reserved.
//

import UIKit


public let kTwitterURL = "http://webdemo-itunesu.rhcloud.com/users/1/tweets"

class RequisitionHelper: NSObject {
    
    class func loadTweets() -> [tweet]? {
        
        let url = NSURL(string: kTwitterURL)
        
        var error: NSError? = nil
        let request = NSURLRequest(URL: url!)
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: &error)
        
        
            if let data = data {
                let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &error) as? [NSDictionary]
                if let json = json {
                    var tweets = [tweet]()
                    for tweetDictionary in json {
                        let id = tweetDictionary["id"] as? Int
                        let message = tweetDictionary["message"] as? String
                        let timestamp = tweetDictionary["timestamp"] as? String
                        
                        if let id = id, message = message, timestamp = timestamp {
                            let tweetr = tweet(id: id, message: message, timestamp: timestamp)
                            tweets.append(tweetr)
                        }
                    }
                return tweets
            }
        }
        return nil
    }
    
    class func testAddTweet(args:String) -> Bool{
        
        let url = NSURL(string: kTwitterURL)
        
        var err: NSError?
        var params = ["message":args] as NSDictionary
        
        let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
        var session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
        // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
        if(err != nil) {
            let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
            println("Error could not parse JSON: '\(jsonStr)'")
        }
        else {
            // The JSONObjectWithData constructor didn't return an error. But, we should still
            // check and make sure that json has a value using optional binding.
            if let parseJSON = json {
                // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                let id = parseJSON["id"] as? Int
                let message = parseJSON["message"] as? String
                let timestamp = parseJSON["timestamp"] as? String
                println("Succes: \(message)")
            }
            else {
                // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: \(jsonStr)")
            }
        }
    })
    
    task.resume()
    return true
    }
}
