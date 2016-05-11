    //
//  Artwork.swift
//  ifceRun
//
//  Created by Carlos Hairon Ribeiro Gonçalves on 13/08/15.
//  Copyright (c) 2015 Carlos Hairon Ribeiro Gonçalves. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

class PointOfInterest: NSObject, MKAnnotation {
    let title: String
    let locationName: String
    let type: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String,
        locationName: String,
        type: String,
        coordinate: CLLocationCoordinate2D) {
            
            self.title = title
            self.locationName = locationName
            self.type = type
            self.coordinate = coordinate
            super.init()
    }
    
    class func fromJSON(json: [JSONValue]) -> PointOfInterest? {
        // 1
        var title: String
        if let titleOrNil = json[0].string {
            title = titleOrNil
        } else {
            title = "" }
        let locationName = json[2].string
        let type = json[1].string
        // 2
        let latitude = (json[3].string! as NSString).doubleValue
        let longitude = (json[4].string! as NSString).doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        // 3
        return PointOfInterest(title: title, locationName: locationName!, type: type!, coordinate: coordinate)
    }
    
    var subtitle: String {
        return locationName
    }
    
    func pinColor() -> MKPinAnnotationColor {
        switch type{
            case "Universidade":
                return .Green
            case "Comercial":
                return .Purple
            default:
                return .Red
        }
    }
    
    func pinImage() -> String {
        switch type{
            case "Universidade":
                return "university"
            case "Comercial":
                return "commercial"
            default:
                return ""
        }
    }
    
    func thereIsImage() -> Bool {
        let image = UIImage(named: pinImage())
        
        if image != nil{
            return true
        }
        return false
    }
    
    func mapItem() -> MKMapItem{
        
        let addressDict = [String(kABPersonAddressStreetKey): subtitle]
        
        let placeMark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = title
        
        return mapItem
    }

}