//
//  ClientConfig.swift
//  EventCast
//
//  Created by Lucas Eduardo on 27/10/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import Foundation
import Alamofire

/// Enum to be throwed by our models, if any validation error is needed
enum BuildError: ErrorType {
    case ValidationError(message: String)
}

/// Enum to be throwed by our models, if any validation error is needed
public protocol ResponseSerializable {
    static var keyPath: String? {get}
    static func build(response response: NSHTTPURLResponse, representation: AnyObject) throws -> Self
}



//MARK: - Default implementation for ResponseSerializable
extension ResponseSerializable {

    /// default implementation. If the json collection uses a keypath, the model should override this property.
    static var keyPath: String? {
        return nil
    }
}

//MARK: - private methods implementation for ResponseSerializable
extension ResponseSerializable {
    
    /**
     Parses a json representation and return an array of serialized objects. For this method, the JSON representation should be an array of dicts, like in [[String: AnyObject]].
     */
    private static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Self] {
        var elements: [Self] = []
        
        var arrayRepresentation: [[String: AnyObject]]!
        
        if let representation = representation as? [[String: AnyObject]] {
            arrayRepresentation = representation
        } else if let dictRepresentation = representation as? [String: AnyObject] {
            if let keyPath = Self.keyPath, let representation = dictRepresentation[keyPath] as? [[String: AnyObject]] {
                arrayRepresentation = representation
            } else {
                assertionFailure("For a collection, if your root JSON is a dictionary, you must provide the keyPath via implementing the keyPath property")
            }
        }
        
        for elementRepresentation in arrayRepresentation {
            let element = try! Self.build(response: response, representation: elementRepresentation) //forcing break if something goes wrong
            elements.append(element)
        }
        
        return elements
    }
}


//MARK: - Public methods for Alamofire.Request
extension Request {
    
    /**
     COLLECTION SERIALIZER - responseCollection.
     
     Gives as response representation an array of serialized objects. Your model should implement the `build(response:, representation:) throws -> Self` method in your model in order to use the responseCollection.
     
     - parameter completionHandler: In the params of the completionHandler, there is the Response object, which have the array of your elements and a possible error. Access it via `response.result.value` or `response.result.error`.
     
     - returns: self.
     */
    public func responseCollection<T: ResponseSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self? {
        
        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            let genericResponse = self.genericResponse(request, response: response, data: data, error: error)
            if let value = genericResponse.value {
                return .Success(T.collection(response: response!, representation: value))
            }
            
            return .Failure(genericResponse.error!)
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    
    /**
     OBJECT SERIALIZER - responseObject.
     
     Gives as response representation a serialized object. Your model should implement the `build(response:, representation:) throws -> Self` method in your model in order to use the responseObject.
     
     - parameter completionHandler: In the params of the completionHandler, there is the Response object, which have the parsed element and a possible error. Access it via `response.result.value` or `response.result.error`.
     
     - returns: self.
     */
    public func responseObject<T: ResponseSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        
        let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
            
            let genericResponse = self.genericResponse(request, response: response, data: data, error: error)
            if let value = genericResponse.value {
                do {
                    let element = try T.build(response: response!, representation: value)
                    return Result.Success(element)
                } catch BuildError.ValidationError(let message) {
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: message)
                    return .Failure(error)
                } catch {
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: "Exception not caught accordly!")
                    return .Failure(error)
                }
            }
            
            return .Failure(genericResponse.error!)
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    /**
     JSON SERIALIZER - customResponseJSON.
     
     Gives a JSON representation of the response data. Needed to create this new method instead of using the Alamofire's responseJSON in order to perform our own validations. For example, the default `responseJSON` does not create an `NSError` when the server returns 500, and this `customResponseJSON` method does that.
     
     - parameter completionHandler: In the params of the completionHandler, there is the Response object, which have the JSON representation, as a AnyObject and a possible error. Access it via `response.result.value` or `response.result.error`. This JSON representation can be a [String : AnyObject] or a [[String : AnyObject]], depending on the JSON structure.
     
     - returns: self.
     */
    public func customResponseJSON(completionHandler: Response<AnyObject, NSError> -> Void) -> Self? {
        
        let responseSerializer = ResponseSerializer<AnyObject, NSError> { request, response, data, error in
            let genericResponse = self.genericResponse(request, response: response, data: data, error: error)
            if let value = genericResponse.value {
                return .Success(value)
            }
            return .Failure(genericResponse.error!)
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}


//MARK: - Private methods for Alamofire.Request
extension Request {
    
    ///Used to generate a generic JSON result. Inside this method, we do our custom validations, and parses the JSON.
    private func genericResponse(request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?) -> Result<AnyObject, NSError> {
        
        let responseSerializer = ResponseSerializer<AnyObject, NSError> { request, response, data, error in
            
            if Config.Alamofire.debugMode {
                debugPrint("Request: \(request!.HTTPMethod!) - \(request!)")
                debugPrint("Request Headers - \(request!.allHTTPHeaderFields)")
            }
            
            guard error == nil else { return .Failure(error!) }
            
            if let response = response where response.statusCode == 500 {
                let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: NSLocalizedString("server_error", comment: "Message shown when server returns error 500"))
                return .Failure(error)
            }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            if Config.Alamofire.debugMode {
                debugPrint(result)
            }
            
            switch result {
            case .Success(let value):
                if response != nil {
                    return .Success(value)
                } else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return responseSerializer.serializeResponse(request, response, data, error)
    }
}