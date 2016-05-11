//
//  ViewController.swift
//  exemploCoreLocation
//
//  Created by Alisson Carvalho on 28/05/15.
//  Copyright (c) 2015 Alisson Carvalho. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var lbLatitude: UILabel!
    @IBOutlet var lbLongitude: UILabel!
    @IBOutlet var lbAltitude: UILabel!
    @IBOutlet var lbPrecisaoV: UILabel!
    @IBOutlet var lbPrecisaoH: UILabel!
    
    @IBOutlet var lbNorteReal: UILabel!
    @IBOutlet var lbNorteM: UILabel!
    
    @IBOutlet var lbEndereco: UILabel!
    @IBOutlet var lbNumero: UILabel!
    @IBOutlet var lbBairro: UILabel!
    @IBOutlet var lbCEP: UILabel!
    @IBOutlet var lbCiddade: UILabel!
    @IBOutlet var lbEstado: UILabel!
    @IBOutlet var lbPais: UILabel!
    
    @IBAction func btLigarGPS(sender: AnyObject) {
        gerenciador.startUpdatingLocation()
        getPlacemarkFromLocation(gerenciador.location)
    }
    
    @IBAction func btDesligarG(sender: AnyObject) {
        gerenciador.stopUpdatingLocation()
        lbLatitude.text = nil
        lbLongitude.text = nil
        lbAltitude.text = nil
        lbPrecisaoH.text = nil
        lbPrecisaoV.text = nil
        
    }
    
    
    @IBAction func btLigarBussola(sender: AnyObject) {
        gerenciador.startUpdatingHeading()
        
       
        
        
        
    }
    
    func getPlacemarkFromLocation(location: CLLocation){
        
        
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    println("reverse geodcode fail: \(error.localizedDescription)")
                    return
                }
                
                var pm : CLPlacemark
                
                pm = CLPlacemark(placemark: placemarks[0] as! CLPlacemark)
                
                
                var  end = pm.addressDictionary as? Dictionary
                let array = end?.keys.array
                var c : Int
                for c = 0 ; c < array!.count; c++ {
                println(array![c])
                }
                println(pm.addressDictionary["Street"] as? String)
//                self.lbEndereco.text = pm.thoroughfare
//                //self.lbNumero.text = pm.
//                self.lbBairro.text = pm.subAdministrativeArea
//                self.lbCEP.text = pm.postalCode
//                self.lbCiddade.text = pm.locality
//                self.lbEstado.text = pm.region.description
//                self.lbPais.text = pm.country
                
                self.lbEndereco.text = pm.addressDictionary["Street"] as? String
                
                var endereco = pm.addressDictionary["Street"] as? String
                let numero = endereco!.componentsSeparatedByString(", ")
                self.lbNumero.text = numero[1]
                self.lbBairro.text = pm.addressDictionary["SubLocality"] as? String
                self.lbCEP.text = pm.addressDictionary["ZIP"] as? String
                self.lbCiddade.text = pm.addressDictionary["City"] as? String
                self.lbEstado.text = pm.addressDictionary["State"] as? String
                self.lbPais.text = pm.addressDictionary["Country"] as? String
                
        })
    }
    
    
    @IBAction func btDesligarBussola(sender: AnyObject) {
        gerenciador.stopUpdatingHeading()
        lbNorteReal.text = nil
        lbNorteM.text = nil
    }
    
    
    let gerenciador = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gerenciador.delegate = self
        gerenciador.desiredAccuracy = kCLLocationAccuracyBest
        gerenciador.requestWhenInUseAuthorization()
        //gerenciador.startUpdatingLocation()
        //gerenciador.startUpdatingHeading()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //metodo para tratar as informacoes de localizacao
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations)
        lbLatitude.text = String(format: "%9.4f", locations[0].coordinate.latitude)
        lbLongitude.text = String(format: "%9.4f", locations[0].coordinate.longitude)
        lbAltitude.text = String(format: "%9.4f", locations[0].altitude)
        lbPrecisaoH.text = String(format: "%9.4f", locations[0].horizontalAccuracy)
        lbPrecisaoV.text = String(format: "%9.4f", locations[0].verticalAccuracy)
    }
    
    //metodo para tratar as informacoes de direcao (bussola)
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        println(newHeading)
        lbNorteReal.text = String(format: "%9.4f", newHeading.trueHeading)
        lbNorteM.text = String(format: "%9.4f", newHeading.magneticHeading)
    }

}

