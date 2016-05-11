//
//  VCMapView.swift
//  ifceRun
//
//  Created by Carlos Hairon Ribeiro Gonçalves on 13/08/15.
//  Copyright (c) 2015 Carlos Hairon Ribeiro Gonçalves. All rights reserved.
//

import Foundation


import MapKit

extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let identifier = "pin"
        
        if let annotation = annotation as? PointOfInterest{
            if annotation.thereIsImage(){
                let identifier = "image"
                return annotationViewFor(mapView, annotation: annotation, identifier: identifier)
            }
            else{
                let identifier = "pin"
                return pinAnnotationViewFor(mapView, annotation: annotation, identifier: identifier)
            }
        }
        
        return nil
        
    }
    
    
    //MARK: Generate Pin
    func pinAnnotationViewFor(mapView:MKMapView, annotation:PointOfInterest, identifier:String)->MKPinAnnotationView{
        
        var view: MKPinAnnotationView
        
        if let dequeueView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView{
            
            dequeueView.annotation = annotation
            view = dequeueView
            
        }
        else{
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5.0, y: 5.0)
            view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
        }
        
        view.pinColor = annotation.pinColor()
        
        return view
        
    }
    
    
    func annotationViewFor(mapView:MKMapView, annotation:PointOfInterest, identifier:String)->MKAnnotationView{
        
        var view: MKAnnotationView
        let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        
        if dequeuedView != nil{
            dequeuedView.annotation = annotation
            view = dequeuedView
        }
        else{
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
        }
        
        view.image = UIImage(named: annotation.pinImage())
        view.frame.size = CGSize(width: 32.0, height: 32.0)
        
        return view
    }

    
    func mapView(mapView: MKMapView!,annotationView view: MKAnnotationView!,calloutAccessoryControlTapped control: UIControl!){
        
        let annotation = view.annotation as! PointOfInterest
        
        if isGoogleMapsInstalled(){
            self.showActionSheet(annotation)
        }
        else{
            self.openWithMaps(annotation)
        }
    }
    
    
    //MARK: Actionsheet
    func showActionSheet(annotation:PointOfInterest){
        let message = NSLocalizedString("Choose an application", comment: "")
        
        let alertViewController:UIAlertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let googleMaps:UIAlertAction = UIAlertAction(title: "Google Maps", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.openWithGoogleMaps(annotation)
        }
        
        let maps:UIAlertAction = UIAlertAction(title: "Maps", style: UIAlertActionStyle.Default) { (alertAction2) -> Void in
            
            self.openWithMaps(annotation)
        }
        
        let cancel:UIAlertAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        alertViewController.addAction(googleMaps)
        alertViewController.addAction(maps)
        alertViewController.addAction(cancel)
        
        self.presentViewController(alertViewController, animated: true, completion: nil)
    }
    
    func openWithMaps(annotation:PointOfInterest) {
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        annotation.mapItem().openInMapsWithLaunchOptions(launchOptions)
        
    }
    
    func openWithGoogleMaps(annotation:PointOfInterest){
       
        let urlString = "comgooglemaps://?q=\(annotation.coordinate.latitude)" + ",\(annotation.coordinate.longitude)"
        
        UIApplication.sharedApplication().openURL((NSURL(string: urlString)!))
    }
    
    func isGoogleMapsInstalled()->Bool{
        let urlString = "comgooglemaps://?q="
        
        return UIApplication.sharedApplication().canOpenURL(NSURL(string:urlString)!)
    }
    
    
}
