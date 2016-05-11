//
//  HeartMonitorVC.swift
//  CoreBluetoothDemo
//
//  Created by João Marcelo on 18/06/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import CoreBluetooth

class HeartMonitorVC: UIViewController, CBPeripheralDelegate {
    
    @IBOutlet weak var hrmLabel: UILabel!
    
    var peripheral: CBPeripheral!
    var serviceUUIDs: [CBUUID]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peripheral.delegate = self
        peripheral.discoverServices(serviceUUIDs)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        if let e = error{
            println("Descoberta de serviços falhou: \(e.localizedDescription)")
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        
        // Descobre as caractísticas para cada serviço descoberto
        for service in peripheral.services as! [CBService] {
            peripheral.discoverCharacteristics(nil, forService: service)
        }
    }
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        if let e = error{
            println("Descoberta de características falhou: \(e.localizedDescription)")
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        
        for characteristic in service.characteristics as! [CBCharacteristic]{
            println("Características: \(characteristic)")
            
            if characteristic.UUID.UUIDString == "2A37"{
                peripheral.setNotifyValue(true, forCharacteristic: characteristic)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        if let e = error{
            println("Notificação falhou: \(e.localizedDescription)")
            return
        }
        displayHeartRateMeasurement(characteristic.value)
        
    }
    
    func displayHeartRateMeasurement(value: NSData){
        
        // Dados chegam em hexadecimal, converter paraxxxxcx decimal
        var buffer = [UInt8](count: value.length, repeatedValue: 0x00)
        value.getBytes(&buffer, length: buffer.count)
        var bpm: UInt16?
        if buffer.count >= 2 {
            if buffer[0] & 0x01 == 0 {
                bpm = UInt16(buffer[1])
            }
            else{
                bpm = UInt16(buffer[1]) << 8
                bpm = bpm! | UInt16(buffer[2])
            }
        }
        
        if let hrm = bpm {
            println("Heart Rate Measurement: \(hrm)")
            hrmLabel.text = "\(hrm)"
        }
        
    
    }
    
}
