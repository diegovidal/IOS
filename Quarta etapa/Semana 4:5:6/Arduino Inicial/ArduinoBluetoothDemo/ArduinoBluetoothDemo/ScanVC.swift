//
//  ScanVC.swift
//  ArduinoBluetoothDemo
//
//  Created by João Marcelo on 19/06/15.
//  Copyright (c) 2015 João Marcelo Oliveira. All rights reserved.
//

import UIKit
import CoreBluetooth

class ScanVC: UIViewController, CBCentralManagerDelegate {
    
    // UUID do serviço do módulo Arduino é FFE0
    var centralManager: CBCentralManager!
    let serviceUUIDs = [CBUUID(string: "FFE0")]
    
    var peripherals = [CBPeripheral]()
    var peripheral: CBPeripheral!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    
    
    // MARK: - CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        
        println("Atualização do Central Manager")
        
        if (central.state == .PoweredOn) {
            println("Bluetooth disponível e pronto")
            centralManager.scanForPeripheralsWithServices(serviceUUIDs, options: nil)
        }
        else {
            println("Bluetooth indisponível")
            
            var message = String()
            switch central.state {
            case .Unsupported:
                message = "Seu dispositivo não suporta Bluetooth"
            case .Unknown:
                message = "O aplicativo não conseguiu acessar o Bluetooth"
            case .Unauthorized:
                message = "O aplicativo não tem autoização para usar Bluetooth"
            case .PoweredOff:
                message = "O Bluetooth está desligado"
            default:
                break
            }
            println(message)
            
            UIAlertView(
                title: "Bluetooth indisponível",
                message: message,
                delegate: nil,
                cancelButtonTitle: "OK")
                .show()
        }
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        println("Periférico descoberto: \(peripheral)")
        
//        var myString: String = peripheral.identifier.description
//        var myStringArray = myString.componentsSeparatedByString(" ")
//        println("Periférico descoberto: \(peripheral)")
        
//        if myStringArray[2] == "30F4A8D3-EC61-0DCE-F1BA-1D03B815522F"{
//            
//            centralManager.connectPeripheral(peripheral, options: nil)
//            peripherals.append(peripheral)
//        }
        
        centralManager.connectPeripheral(peripheral, options: nil)
        peripherals.append(peripheral)
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        println("Periférico pareado: \(peripheral)")
        
        // Para de escanear para economizar bateria
        centralManager.stopScan()
        peripherals.removeAll(keepCapacity: false)
        
        self.peripheral = peripheral
        
        performSegueWithIdentifier("Arduino", sender: self)
    }
    
    func centralManager(central: CBCentralManager!, didFailToConnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        println("Conexão falhou: \(peripheral)")
        
        UIAlertView(
            title: "Pareamento falhou",
            message: "Não foi possível conectar com o Arduino: \(error.localizedDescription)",
            delegate: nil,
            cancelButtonTitle: "OK")
            .show()
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let arduinoVC = segue.destinationViewController as! ArduinoVC
        arduinoVC.peripheral = self.peripheral
    }
    
}
