//
//  ViewController.swift
//  iBeacon-demo
//
//  Created by Diego Vidal on 25/06/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit
// PASSO 1
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // PASSO 2 - uuidgen
    // Instância das variáveis
    var peripheralManager: CBPeripheralManager = CBPeripheralManager(delegate: nil, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
    
    var uuid: NSUUID! = NSUUID(UUIDString: "E31D6EB9-FF63-4128-9E4D-C6A9FD9219BD")
    var region: CLBeaconRegion = CLBeaconRegion()
    
    var locationManager: CLLocationManager! = CLLocationManager()
    //var beaconsFound: [AnyObject] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // PASSO 3
        // Define a região
        region = CLBeaconRegion(proximityUUID: uuid, major: 0, minor: 0, identifier: "bepid")
        
        // Aplica o delegate
        locationManager.delegate = self
        
        // Pede autorização
        locationManager.requestWhenInUseAuthorization()
        
        // Define a região do CoreLocation
        locationManager.startMonitoringForRegion(region)
        
        // Começa a transmitir
        startTransmission()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // PASSO 4
    // Transmite iBeacon
    func startTransmission(){
        
        locationManager.stopRangingBeaconsInRegion(region)
        var peripheralData = region.peripheralDataWithMeasuredPower(nil) as NSDictionary
        if peripheralData.count > 0{
            println("Começou a transmitir")
            peripheralManager.startAdvertising(peripheralData as! [NSObject : AnyObject])
        }
        
        
    }
    
    // PASSO 5
    // Procura iBeacon
    func startRanging(){
        println("Começou a procurar")
        peripheralManager.stopAdvertising()
        locationManager.startRangingBeaconsInRegion(region)
    }
    
    // PASSO 6
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        //let closestBeaconsbeacons= beacons.filter{ $0.proximity != CLProximity.Immediate }
        println("Beacons: \(beacons)")
        if beacons.count > 0{
            var beacon: CLBeacon = beacons[0] as! CLBeacon
        }
    }
    
    // PASSO 7
    @IBAction func chooseType(sender: UISwitch) {
        
        if sender.on{
            startTransmission()
        }
        else{
            startRanging()
        }
    }

}

