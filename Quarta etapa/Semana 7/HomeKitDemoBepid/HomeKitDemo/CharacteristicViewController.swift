//
//  CharacteristicViewController.swift
//  HomeKitDemo
//
//  Created by Ricardo Torquato Tavares on 30/06/15.
//  Copyright (c) 2015 com.br.bepid. All rights reserved.
//

import UIKit
import HomeKit

class CharacteristicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet var accessoriesTableView : UITableView!
    
    //HomeKit
    var characteristics = [HMCharacteristic]()
    var selectService: HMService?{
        didSet{
            self.title = selectService?.name
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCharacteristics()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadCharacteristics(){
        characteristics.removeAll(keepCapacity: true)
        if let selectService = selectService {
            for characteristic in selectService.characteristics as! [HMCharacteristic] {
                if !contains(characteristics, characteristic){
                    characteristics.append(characteristic)
                }
            }
            accessoriesTableView?.reloadData()
        }
    }
    
    //MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characteristics.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func generateGeneralCell(tableView: UITableView, indexPath: NSIndexPath, object: HMCharacteristic) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        if let charDesc = HomeKitUUIDs[object.characteristicType] {
            cell.detailTextLabel?.text = charDesc
        }else{
            cell.detailTextLabel?.text = object.characteristicType
        }
        if (object.value != nil) {
            cell.textLabel?.text = "\(object.value)"
        }else{
            cell.textLabel?.text = ""
        }
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let object = characteristics[indexPath.row] as HMCharacteristic
        
        return generateGeneralCell(tableView, indexPath: indexPath, object: object)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let characteristic = characteristics[indexPath.row] as HMCharacteristic
        if contains((characteristic.properties as! [String]), (HMCharacteristicPropertyWritable as String)) {
            return true
        }
        return false
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let object = characteristics[indexPath.row] as HMCharacteristic
        
        if !contains(object.properties as! [String], HMCharacteristicPropertyWritable as String) {
            return
        }
        
        if let charaType = object.characteristicType {
            NSLog("Char:\(charaType)")
        }
        
        if let metadata = object.metadata {
            println("Meta:\(metadata)")
        }
        
        if let properties = object.properties {
            NSLog("Properties:\(properties)")
        }
        
        switch object.characteristicType as NSString {
        case HMCharacteristicTypeIdentify:
            object.writeValue(true, completionHandler:
                {
                    (error:NSError!) in
                    if (error != nil) {
                        NSLog("Change Char Error: \(error)")
                    }
                }
            )
        default:
            var charDesc = object.characteristicType
            if let desc = HomeKitUUIDs[object.characteristicType] {
                charDesc = desc
            }
            switch (object.metadata.format as NSString) {
            case HMCharacteristicMetadataFormatBool:
                if (object.value != nil) {
                    object.writeValue(!(object.value as! Bool), completionHandler:
                        {
                            (error:NSError!) in
                            if (error != nil) {
                                NSLog("Change Char Error: \(error)")
                            }else{
                                dispatch_async(dispatch_get_main_queue(),
                                    {
                                        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                                            cell.textLabel?.text = "\(object.value)"
                                        }
                                    }
                                )
                            }
                        }
                    )
                } else {
                    object.writeValue(true, completionHandler:
                        {
                            (error:NSError!) in
                            if (error != nil) {
                                NSLog("Change Char Error: \(error)")
                            }
                        }
                    )
                }
            default:
                NSLog("Unsupported")
            }
        }
    }

}
