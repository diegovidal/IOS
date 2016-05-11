//
//  RequesitionHelperTest.swift
//  demo2-tests
//
//  Created by Diego Vidal on 19/05/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit
import XCTest

class RequesitionHelperTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func atestLoadTweets(){
        let url = NSURL(string: kTwitterURL)
        XCTAssertNotNil(url, "NSURL é nula!")
        
        var error: NSError? = nil
        let request = NSMutableURLRequest(URL: url!)
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: &error)
        XCTAssertNotNil(data, "NSData é nula")
        
        let json = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers, error: &error) as? [NSDictionary]
        XCTAssertNotNil(json, "Parse do JSON falhou!")
        
        for tweetDictionary in json!{
            let id = tweetDictionary["id"] as? Int
            XCTAssertNotNil(id, "campo id ausente")
            
            let message = tweetDictionary["message"] as? String
            XCTAssertNotNil(message, "campo message ausente")
            
            let timestamp = tweetDictionary["timestamp"] as? String
            XCTAssertNotNil(message, "campo timestamp ausente")
        }
        
        //let tweets = RequesitionHelper.loadTweets()
        //XCTAssertNotNil(tweets, "Array de tweets nulo!")
    }
    
    func testAddTweet(){
        let url = NSURL(string: kTwitterURL)
        XCTAssertNotNil(url, "NSURL é nula!")
        
        var error: NSErrorPointer = nil
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var dictionaryExample = ["message":"seilaqualquercoisa2"]
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(dictionaryExample, options: .PrettyPrinted, error: error)
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: error)
        XCTAssertNotNil(data, "NSData é nula")
        
        let json = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers, error: error) as? NSDictionary
        XCTAssertNotNil(json, "Parse do JSON falhou!")
        
        
        
    }
    
    func testDeleteTweet(){
    
    }

}
