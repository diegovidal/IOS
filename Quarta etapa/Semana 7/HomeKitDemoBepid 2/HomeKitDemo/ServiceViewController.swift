//
//  ServiceViewController.swift
//  HomeKitDemo
//
//  Created by Ricardo Torquato Tavares on 30/06/15.
//  Copyright (c) 2015 com.br.bepid. All rights reserved.
//

import UIKit
import HomeKit

class ServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    //Outlets
    @IBOutlet var accessoriesTableView : UITableView!
    
    //Homekit
    //Declaramos services (HMService) 
    //...
    var services = [HMService]()
    
    var selectAccessory: HMAccessory?{
        didSet{
            self.title = selectAccessory?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadServices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadServices(){
        services.removeAll(keepCapacity: true)
        if let selectAccessory = selectAccessory {
            for service in selectAccessory.services as! [HMService] {
                if !contains(services, service) {
                    services.append(service)
                }
            }
            accessoriesTableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCharacteristic" {
            let indexPath = accessoriesTableView?.indexPathForSelectedRow()
            if let indexPath = indexPath {
                let object = services[indexPath.row] as HMService
                accessoriesTableView?.deselectRowAtIndexPath(indexPath, animated: true)
                (segue.destinationViewController as! CharacteristicViewController).selectService = object
            }
        }
    }

    //MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let object = services[indexPath.row] as HMService
        if (object.name != nil) {
            cell.textLabel?.text = object.name
            if let serviceDesc = HomeKitUUIDs[object.serviceType] {
                cell.detailTextLabel?.text = serviceDesc
            }else{
                cell.detailTextLabel?.text = object.serviceType
            }
        }else{
            if let serviceDesc = HomeKitUUIDs[object.serviceType] {
                cell.detailTextLabel?.text = serviceDesc
            }else{
                cell.detailTextLabel?.text = object.serviceType
            }
            cell.detailTextLabel?.text = ""
        }
        return cell
    }

}
