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
        if let annotation = annotation as? DynamicAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            }
            else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as!
                UIView
            }
           
            view.pinColor = annotation.pinColor()
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView!,annotationView view: MKAnnotationView!,calloutAccessoryControlTapped control: UIControl!){
        
    
        let location = view.annotation as! DynamicAnnotation
        if isGoogleMapsInstalled(){
            self.showActionSheet(location)
         
        }
        else{
            self.openWithMaps(location)
        }
    }
    
    
    
    
    
    
    
    //MARK: Actionsheet
    
    func showActionSheet(annotation:DynamicAnnotation){
        let message = NSLocalizedString("Choose an application", comment: "")
        
        let alertViewController:UIAlertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let googleMaps:UIAlertAction = UIAlertAction(title: "Google Maps", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.openWithGoogleMaps(annotation)
        }
        
        let maps:UIAlertAction = UIAlertAction(title: "Maps", style: UIAlertActionStyle.Default) { (alertAction2) -> Void in
            self.openWithMaps(annotation)
        }
        
        let titleCancel = NSLocalizedString("Cancel", comment: "")
        let cancel:UIAlertAction = UIAlertAction(title: titleCancel, style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        alertViewController.addAction(googleMaps)
        alertViewController.addAction(maps)
        alertViewController.addAction(cancel)
        
        self.presentViewController(alertViewController, animated: true, completion: nil)
    }
    
    func openWithMaps(annotation:DynamicAnnotation) {
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        annotation.mapItem().openInMapsWithLaunchOptions(launchOptions)
        
        
    }
    
    func openWithGoogleMaps(annotation:DynamicAnnotation){
        let urlString = "comgooglemaps://?q=\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)"
        
        UIApplication.sharedApplication().openURL(NSURL(string:urlString)!)
        
    }
    
    func isGoogleMapsInstalled()->Bool{
        let urlString = "comgooglemaps://?q="

        return UIApplication.sharedApplication().canOpenURL(NSURL(string:urlString)!)
    }

    
    
}
