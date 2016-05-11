//
//  ScanVC.swift
//  CoreBluetoothDemo
//
//  Created by João Marcelo on 18/06/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import CoreBluetooth

class ScanVC: UIViewController, CBCentralManagerDelegate {
    
    var centralManager: CBCentralManager!
    let serviceUUIDs = [CBUUID(string: "180D")]
    
    var peripherals = [CBPeripheral]()
    var peripheral: CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        
        if central.state == .PoweredOn{
            
            println("Bluetooth disponível")
            
            centralManager.scanForPeripheralsWithServices(serviceUUIDs, options: nil)
            
        }
        else{
            println("Bluetooth indisponível")
            
            // Para de escanear para economizar bateria
            centralManager.stopScan()
        }
        
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        println("Periférico descoberto: \(peripheral)")
        
        // Para de escanear
        centralManager.stopScan()
        
        // Conecta ao periférico descoberto
        centralManager.connectPeripheral(peripheral, options: nil)
        
        // Se não mantiver a referência, o sistema vai dar release na variável e não disparará nem o delegate de conexão sucedida nem de falha (logo a seguir)
        peripherals.append(peripheral)
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        println("Periférico pareado: \(peripheral)")
        
        // Salva referência do periférico e segue para a próxima tela
        self.peripheral = peripheral
        performSegueWithIdentifier("HearMonitorVC", sender: self)
    }
    
    func centralManager(central: CBCentralManager!, didFailToConnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        centralManager.scanForPeripheralsWithServices(serviceUUIDs, options: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let heartMonitorVC = segue.destinationViewController as! HeartMonitorVC
        heartMonitorVC.peripheral = self.peripheral
        heartMonitorVC.serviceUUIDs = self.serviceUUIDs as! [CBUUID]
    }

}
