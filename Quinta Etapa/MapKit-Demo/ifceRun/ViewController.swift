//
//  ViewController.swift
//  ifceRun
//
//  Created by Carlos Hairon Ribeiro Gonçalves on 13/08/15.
//  Copyright (c) 2015 Carlos Hairon Ribeiro Gonçalves. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    // this uint in meters
    let regionRadius: CLLocationDistance = 1000
    
    var points = [PointOfInterest]()
    let locationManager = CLLocationManager()
    
    
    //
    func centerMapOnLocation(location: CLLocation) {
        //metodo para centralizar o mapa nessa localizacao
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //IFCE initialLocation
        let initialLocation = CLLocation(latitude: -3.743739,
                                         longitude: -38.535901)
        
        mapView.delegate = self
        centerMapOnLocation(initialLocation)
        
        loadInitialData() //carrega os dados do JSON
        mapView.addAnnotations(points)
        //placeIFCE()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        configLocationManager()
    }
    

    func placeIFCE() {
        let pointOfInterest = PointOfInterest(title: "IFCE", locationName: "Av. 13 de Maio 2081", type: "Universidade", coordinate: CLLocationCoordinate2D(latitude: -3.743739, longitude: -38.535901))
        
        mapView.addAnnotation(pointOfInterest)
    }
    
   func loadInitialData() {
        // 1
        let fileName = NSBundle.mainBundle().pathForResource("Benfica", ofType: "json");
        var readError : NSError?
        var data: NSData = NSData(contentsOfFile: fileName!, options: NSDataReadingOptions(0),
            error: &readError)!
        // 2
        var error: NSError?
        let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions(0), error: &error)
        // 3
        if let jsonObject = jsonObject as? [String: AnyObject] where error == nil,
            // 4
            let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
                for artworkJSON in jsonData {
                    if let artworkJSON = artworkJSON.array,
                        // 5
                        point = PointOfInterest.fromJSON(artworkJSON) {
                            
                            points.append(point)
                    }
                }
        }
    }
    
    //MARK: Location manager methods
    
    func configLocationManager(){
        
        //configura o locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorizationStatus()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        mapView.showsUserLocation = true;
        locationManager.stopUpdatingLocation()
    }
    
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true;
        }
        else{
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    
    //MARK: MapType
    
    @IBAction func changeMapType(sender: UISegmentedControl) {
        
        let mapType = sender.selectedSegmentIndex
        
        switch mapType{
            case 0:
                mapView.mapType = MKMapType.Standard
            case 1:
                mapView.mapType = MKMapType.Hybrid
            case 2:
                mapView.mapType = MKMapType.Satellite
            default:
                break
        }
        
    }
    
    

    
}

