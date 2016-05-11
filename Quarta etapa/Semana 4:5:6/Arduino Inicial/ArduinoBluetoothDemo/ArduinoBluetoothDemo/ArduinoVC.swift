//
//  ArduinoVC.swift
//  ArduinoBluetoothDemo
//
//  Created by João Marcelo on 20/06/15.
//  Copyright (c) 2015 João Marcelo Oliveira. All rights reserved.
//

import UIKit
import CoreBluetooth

class ArduinoVC: UIViewController, CBPeripheralDelegate {
    
    @IBOutlet weak var ledSwitch: UISwitch!
    
    var peripheral: CBPeripheral!
    var serviceUUIDs = [CBUUID(string: "FFE0")]
    var characteristicUUIDs = [CBUUID(string: "FFE1")]
    
    var characteristic: CBCharacteristic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peripheral.delegate = self
        peripheral.discoverServices(serviceUUIDs)
    }
    
    
    
    // MARK: - CBPeripheralDelegate
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        
        if let e = error {
            println("Descoberta de serviços falhou: \(e.localizedDescription)")
            
            UIAlertView(
                title: "Pareamento falhou",
                message: "Não foi possível obter os serviços do Arduino: \(e.localizedDescription)",
                delegate: nil,
                cancelButtonTitle: "OK")
                .show()
            
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        
        // Neste exemplo, temos certeza que só foi descoberto um serviço: FFE0
        let service = peripheral.services.first as! CBService
        peripheral.discoverCharacteristics(characteristicUUIDs, forService: service)
    }
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        
        if let e = error {
            println("Descoberta de características falhou: \(e.localizedDescription)")
            
            UIAlertView(
                title: "Pareamento falhou",
                message: "Não foi possível obter as características do Arduino: \(e.localizedDescription)",
                delegate: nil,
                cancelButtonTitle: "OK")
                .show()
            
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        
        self.characteristic = service.characteristics.first as! CBCharacteristic
        
        // Neste exemplo, temos certeza que a característica é FFE1
        //let characteristic = service.characteristics.first as! CBCharacteristic
        //peripheral.setNotifyValue(true, forCharacteristic: characteristic)
    }
    
    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        
        if let e = error {
            println("Notificação falhou: \(e.localizedDescription)")
            return
        }
        
        // Neste exemplo, temos certeza que a característica é FFE1
        // 1. O valor chega em hexadecimal como NSData
        // 2. Convertemos o hexadecimal NSData para String
        // 3. Traduzimos o hexadecimal String para uma String legível
        let stringValue = characteristic.value.hexadecimalString().stringFromHexadecimalStringUsingEncoding(NSUTF8StringEncoding)
        println("Notificação do valor: \(stringValue)")
        
        if let value = stringValue {
            ledSwitch.on = value.hasPrefix("1")
        }
    }
    
    @IBAction func didTapLedSwitch(sender: UISwitch) {
        
        let value = sender.on ? "1" : "0"
        
        // Encoda o valor para UTF8 e converte para base 64
        let valueUtf8 = value.dataUsingEncoding(NSUTF8StringEncoding)
        
        if let valueBase64 = valueUtf8?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0)){
            // Escreve valor
            peripheral.writeValue(NSData(base64EncodedString: valueBase64, options: nil), forCharacteristic: characteristic, type: CBCharacteristicWriteType.WithoutResponse)
        }
        
    }
}
