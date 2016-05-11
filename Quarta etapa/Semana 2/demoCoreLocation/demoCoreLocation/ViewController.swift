//
//  ViewController.swift
//  demoCoreLocation
//
//  Created by Yuri Reis on 28/05/15.
//  Copyright (c) 2015 ifce.edu.br. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var lbLatitude: UILabel!
    @IBOutlet weak var lbLongitude: UILabel!
    @IBOutlet weak var lbAltitude: UILabel!
    @IBOutlet weak var lbVerticalPrec: UILabel!
    @IBOutlet weak var lbHorizontalPrec: UILabel!
    @IBOutlet weak var lbRealNorth: UILabel!
    @IBOutlet weak var lbMagNorth: UILabel!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        lbLatitude.text = String(format: "%9.4f", locations[0].coordinate.latitude)
        lbLongitude.text = String(format: "%9.4f", locations[0].coordinate.longitude)
        lbAltitude.text = String(format: "%9.4f", locations[0].altitude)
        lbVerticalPrec.text = String(format: "%9.4f", locations[0].verticalAccuracy)
        lbHorizontalPrec.text = String(format: "%9.4f", locations[0].horizontalAccuracy)
        
//        var geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(locations[0] as! CLLocation, completionHandler: { (placemarks, error) -> Void in
//            var placemark = placemarks[0] as! CLPlacemark
        
//            self.lbLatitude.text = placemark.addressDictionary["Street"] as! String
//            self.lbLongitude.text = placemark.addressDictionary["Country"] as! String
//        })
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        println(newHeading)
        lbRealNorth.text = String(format: "%9.4f", newHeading.trueHeading)
        lbMagNorth.text =  String(format: "%9.4f", newHeading.magneticHeading)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startGPS(sender: AnyObject) {
        manager.startUpdatingLocation()
    }

    @IBAction func stopGPS(sender: AnyObject) {
        manager.stopUpdatingLocation()
        lbLatitude.text = nil
        lbLongitude.text = nil
        lbAltitude.text = nil
        lbVerticalPrec.text = nil
        lbHorizontalPrec.text = nil
    }
    
    @IBAction func startMagnetometer(sender: AnyObject) {
        manager.startUpdatingHeading()
    }
    
    @IBAction func stopMagnetometer(sender: AnyObject) {
        manager.stopUpdatingHeading()
        lbRealNorth.text = nil
        lbMagNorth.text = nil
    }
    
}

