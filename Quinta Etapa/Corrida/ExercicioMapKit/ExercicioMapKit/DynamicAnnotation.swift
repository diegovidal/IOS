//
//  DynamicPinAnnotation.swift
//  ExercicioMapKit
//
//  Created by José Lucas Souza das Chagas on 16/08/15.
//  Copyright (c) 2015 José Lucas Souza das Chagas. All rights reserved.
//

import UIKit
import MapKit
import AddressBook
class DynamicAnnotation:NSObject, MKAnnotation {
   
    let name: String
    let coordinate: CLLocationCoordinate2D
    var position:Int
    var velocity:Double
    
    init(name: String,position:Int,coordinate: CLLocationCoordinate2D,velocity:Double) {
        
        self.name = name
        self.coordinate = coordinate
        self.position = position
        self.velocity = velocity
        super.init()
        
    }

 
    func pinColor() -> MKPinAnnotationColor  {
        switch position {
        case 1:
            return .Red
        default:
            return .Green
        
            
        }
    }
    
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): name]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        return mapItem
    }
    
    var subtitle: String {
        return "Velocity: \(self.velocity)"
    }
    
    var title:String{
        return name
    }

}
