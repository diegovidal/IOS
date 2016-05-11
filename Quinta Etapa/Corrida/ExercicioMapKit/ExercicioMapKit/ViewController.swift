//
//  ViewController.swift
//  ExercicioMapKit
//
//  Created by José Lucas Souza das Chagas on 16/08/15.
//  Copyright (c) 2015 José Lucas Souza das Chagas. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {

    let urlString:String = "http://gps-luanjames.rhcloud.com/"
    var configCamera:Bool = true
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.clearsContextBeforeDrawing = true
        mapView.delegate = self
        
        
        
        configLocationManager()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configMapCamera(centerLocation: CLLocation,regionRadius:CLLocationDistance) {
        
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            centerLocation.coordinate,
            regionRadius * 2.0, // eixo y
            regionRadius * 2.0) // eixo x
        
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func getRadius()->Double{
        var dist:Double = 0
        
        if mapView.annotations.count > 1{
            for annotation in mapView.annotations{
                
                if let dynamicAnnotation = annotation as? DynamicAnnotation{
                    let annotationLocation = CLLocation(latitude: dynamicAnnotation.coordinate.latitude, longitude: dynamicAnnotation.coordinate.longitude)
                    var newDist = mapView.userLocation.location.distanceFromLocation(annotationLocation)
                    if dist < newDist{
                        dist = newDist
                    }
                    
                    
                }
                
            }
            return dist
        }
        
        return 1000
        
    }
    
    
    //MARK: CLLocation manager  methods
    
    func configLocationManager(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        checkLocationAuthorizationStatus()
    }

    func checkLocationAuthorizationStatus() {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        locationManager.stopUpdatingLocation()
        mapView.showsUserLocation = true
        if let newLocation = locations.last as?CLLocation{
            configMapCamera(newLocation,regionRadius:getRadius())

        }
        self.updadeAnnotationsPosition()
    }
    
    
    //MARK: Updade Annotation methods
    
    //agenda de quanto em quanto tempo sera mandada a requisicao
    func scheduleUpdates(interval:Double,shouldRepeat:Bool){
        var timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector:"updadeAnnotationsPosition", userInfo: nil, repeats: false)

    }
    
    //atualiza a posicao dos pinos apos ter recebido a resposta do metodo loadDynamicsAnnotationPosition
    func updadeAnnotationsPosition(){
        
        loadDynamicsAnnotationPosition { (newAnnotations, success) -> () in
            if success{
                if let annotations = newAnnotations{
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    let someLocation = CLLocation(latitude: -3.743739, longitude: -38.535901)
                    
                    self.mapView.addAnnotations(annotations)
                    if self.configCamera{
                        if self.mapView.userLocation.location != nil{
                            self.configMapCamera(self.mapView.userLocation.location, regionRadius: self.getRadius())
                            self.configCamera = false

                        }
                    }
                }
                self.scheduleUpdates(2, shouldRepeat: false)

            }
        }
    }
    
    
    func convertStringToCLLocation2D(string:String)->CLLocationCoordinate2D?{
        if let virgulaIndex = find(string, ","){
            let latitude = string.substringToIndex(virgulaIndex)
            let longitude = string.substringFromIndex(virgulaIndex.successor())
            
            return CLLocationCoordinate2D(latitude: NSString(string: latitude).doubleValue, longitude: NSString(string: longitude).doubleValue)
        }
        
        return nil
    }
    
    //Le o Json do WebService e cria um array de DynamicAnnotations
    func loadDynamicsAnnotationPosition(completionHandler:(annotations:[DynamicAnnotation]?,success:Bool)->()){
        
        
        /*{"vel":22,"pos":"-3.744334721337975,-38.53719888843696"},{"vel":24,"pos":"-3.7439567688639177,-38.53701089887778"},{"vel":25,"pos":"-3.743696098677887,-38.536862693658115"},{"vel":19,"pos":"-3.7447631667820738,-38.53678379720455"}]*/
        
        let url = NSURL(string: urlString)
        
        let request:NSURLRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil{
                
                var annotations:[DynamicAnnotation]? = [DynamicAnnotation]()
                var serializationError:NSError?
                
                if let elements = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: &serializationError) as? [NSMutableDictionary]{
                    
                    for index in 0..<elements.count{
                        
                        let element = elements[index] as NSDictionary
                        
                        if let coordinateString = element.valueForKey("pos") as? String{
                            
                            if let coordinate = self.convertStringToCLLocation2D(coordinateString){
                                
                                let car = DynamicAnnotation(name: "car \(index)", position: index, coordinate:coordinate, velocity: element.valueForKey("vel") as! Double)
                                annotations?.append(car)

                            }
                        }
                    }
                    
                }
                
                completionHandler(annotations: annotations, success: true)
                
            }
            else{
                completionHandler(annotations: nil, success: false)
            }
        }
    }
    
    

}



