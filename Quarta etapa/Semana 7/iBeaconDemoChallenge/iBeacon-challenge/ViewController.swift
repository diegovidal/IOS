//
//  ViewController.swift
//  iBeacon-challenge
//
//  Created by Diego Vidal on 26/06/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth


class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, ViewControllerDelegate {
    
    @IBOutlet weak var switchType: UISwitch!
    @IBOutlet weak var tableBeacons: UITableView!
    
    var peripheralManager: CBPeripheralManager = CBPeripheralManager(delegate: nil, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
    var uuid: NSUUID! = NSUUID(UUIDString: "E31D6EB9-FF63-4128-9E4D-C6A9FD9219BD")
    var region: CLBeaconRegion = CLBeaconRegion()
    
    var locationManager: CLLocationManager! = CLLocationManager()
    var beaconsFound: [Beacon]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define a região
        region = CLBeaconRegion(proximityUUID: uuid, major: 0, minor: 0, identifier: "bepid")
        
        // Aplica o delegate e faz a requisição da autorização
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Define a região do CoreLocation
        locationManager.startMonitoringForRegion(region)
        
        // Começa a transmitir
        startTransmission()
        
        // Instancia a Array
        beaconsFound = Array()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Transmitindo iBeacon
    func startTransmission(){
        
        locationManager.stopRangingBeaconsInRegion(region)
        var peripheralData = region.peripheralDataWithMeasuredPower(-59) as NSDictionary
        if peripheralData.count > 0{
            println("Começou a transmitir")
            peripheralManager.startAdvertising(peripheralData as! [NSObject : AnyObject])
        }
        
        
    }
    
    // Procura iBeacon
    func startRanging(){
        println("Começou a receber")
        peripheralManager.stopAdvertising()
        locationManager.startRangingBeaconsInRegion(region)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        println("Beacons: \(beacons)")
        if beacons.count > 0{
            var beacon: CLBeacon = beacons[0] as! CLBeacon
            if beaconIsDiferent(beacon.major){
                let alertController: UIAlertController = UIAlertController(title: "Aviso!", message: "Você deseja cadastrar o beacon encontrado?", preferredStyle:.ActionSheet)
                
                let action1 = UIAlertAction(title: "Sim", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
                    self.performSegueWithIdentifier("segueCreateBeacon", sender: beacon.major)
                })
                let action2 = UIAlertAction(title: "Não", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
                })
                
                alertController.addAction(action1)
                alertController.addAction(action2)
                self.presentViewController(alertController, animated: true, completion: { () -> Void in
                    self.switchType.setOn(true, animated: true)
                    self.startTransmission()
                })
            }
            else{
                let alertController: UIAlertController = UIAlertController(title: "Aviso!", message: "\((beaconIsClose(beacon.major))) está próximo de você", preferredStyle:.ActionSheet)
                
                let action = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: { (alert: UIAlertAction!) -> Void in
                })
                
                println("\((beaconIsClose(beacon.major))) está próximo de você")
                alertController.addAction(action)
                self.presentViewController(alertController, animated: true, completion: { () -> Void in
                    self.switchType.setOn(true, animated: true)
                    self.startTransmission()
                })

            }
        }
    }
    
    func beaconIsDiferent(major: NSNumber) -> Bool{
        for beacon in beaconsFound{
            if beacon.major == major{
                return false
            }
        }
        return true
    }
    
    func beaconIsClose(major: NSNumber) -> String{
        for beacon in beaconsFound{
            if beacon.major == major{
             return beacon.nome
            }
        }
        return ""
    }
    
    func addBeacon(beacon: Beacon){
        beaconsFound.append(beacon)
        tableBeacons.reloadData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return beaconsFound.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("iBeaconCell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        cell.textLabel?.text = beaconsFound[indexPath.row].nome
        
        return cell
    }
    
    @IBAction func chooseType(sender: UISwitch) {
        if sender.on{
            startTransmission()
        }
        else{
            startRanging()
        }
        
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueCreateBeacon"{
            let createBeacon:CreateBeacon  = segue.destinationViewController as! CreateBeacon
            createBeacon.majorReceived = sender as? NSNumber
            createBeacon.delegate = self
            
            
        }
    }
    

}
