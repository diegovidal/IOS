//
//  AccessoryViewController.swift
//  HomeKitDemo
//
//  Created by Ricardo Torquato Tavares on 29/06/15.
//  Copyright (c) 2015 com.br.bepid. All rights reserved.
//

import UIKit
import HomeKit
//Protocolos
//...
class AccessoryViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, HMHomeManagerDelegate, HMHomeDelegate, HMAccessoryDelegate {
    
    //Declaramos homeManager (HMHomeManager) e Array de acessorios(HMAccessory)
    //...
    //HomeKit
    var homeManager: HMHomeManager = HMHomeManager()
    var accessories = [HMAccessory]()
    
    //Outlets
    @IBOutlet var accessoriesTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate homeManager
        //...
        homeManager.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.updateAccessories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //pegar os acessorios da homePrimary e guardar no array
    func updateAccessories(){
        //...
        if CoreHome.sharedInstance.homePrimary != nil{
            if let objects = CoreHome.sharedInstance.homePrimary!.accessories as? [HMAccessory]{
                for accessory in objects{
                    if !contains(accessories, accessory){
                        accessories.insert(accessory, atIndex: 0)
                        accessory.delegate = self
                    }
                }
            }
            accessoriesTableView.reloadData()
        }
    }
 
    //remover todos os acessorios do array (removeAll)
    func removeEverything() {
        //...
        self.accessories.removeAll(keepCapacity: false)
    }
    
    //MARK:- HomeKit
    
    //addHome
    func homeManagerDidUpdateHomes(manager: HMHomeManager) {
        NSLog("DidUpdateHomes:\(manager)")
        if self.homeManager.primaryHome == nil {
            let alert:UIAlertController = UIAlertController(title: "Create new Home", message: "You need a new home to continue", preferredStyle: .Alert)
            alert.addTextFieldWithConfigurationHandler(nil)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.Default, handler:
                {
                    (action:UIAlertAction!) in
                    let textField = alert.textFields?[0] as! UITextField
                    
                    //adiciona uma nova Casa
                    self.homeManager.addHomeWithName(textField.text, completionHandler:
                        {
                            (home:HMHome!, error:NSError!) in
                            if error != nil {
                                NSLog("Failed adding home, Error:\(error)")
                            } else {
                                NSLog("New Home \(home)")
                                // set casa para PrimaryHome
                                self.homeManager.updatePrimaryHome(home, completionHandler:
                                    {
                                        (error:NSError!) in
                                        if error != nil {
                                            NSLog("Failed updating primary home, Error: \(error)")
                                        } else {
                                            // atualiza a primaryHome do CoreHome
                                            NSLog("DidSetPrimaryHome")
                                            CoreHome.sharedInstance.homePrimary = self.homeManager.primaryHome
                                            CoreHome.sharedInstance.homePrimary!.delegate = self
                                        }
                                    }
                                )
                            }
                    })
            }))
            dispatch_async(dispatch_get_main_queue(),
                {
                    self.presentViewController(alert, animated: true, completion: nil)
            })
        }else{
            // atualiza a primaryHome do CoreHome
            NSLog("Find primary Home :)")
            CoreHome.sharedInstance.homePrimary = self.homeManager.primaryHome
            CoreHome.sharedInstance.homePrimary!.delegate = self
            removeEverything()
            self.updateAccessories()
        }
    }
    
    //MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accessories.count
    }
    
    //compara se o acessorio está alcançável (reachable) ou não
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let object = accessories[indexPath.row] as HMAccessory
        if object.reachable{
            cell.textLabel?.textColor = UIColor(red: 0.043, green: 0.827, blue: 0.094, alpha: 1.0)
        }
        else{
            cell.textLabel?.textColor = UIColor.redColor()
        }
        
        cell.textLabel?.text = object.name
        cell.detailTextLabel?.text = object.room?.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var options = [UITableViewRowAction]()
        
        if indexPath.row < accessories.count{
            
            let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:
                {
                    [weak self]
                    (action:UITableViewRowAction!, indexPath:NSIndexPath!) in
                    CoreHome.sharedInstance.homePrimary!.removeAccessory(self?.accessories[indexPath.row], completionHandler: { (error: NSError!) -> Void in
                        if error != nil {
                            NSLog("Delete Accessory error: \(error)")
                        }else{
                            dispatch_async(dispatch_get_main_queue(),
                                {
                                    self?.accessories.removeAtIndex(indexPath.row)
                                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                                }
                                
                            )
                        }
                        }
                    )
                    tableView.setEditing(false, animated: true)
                }
            )
            options.append(deleteAction)
            
        }
        return options
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = accessoriesTableView.indexPathForSelectedRow()
            if let indexPath = indexPath {
                let object = accessories[indexPath.row] as HMAccessory
                accessoriesTableView.deselectRowAtIndexPath(indexPath, animated: true)
                (segue.destinationViewController as! ServiceViewController).selectAccessory = object
            }
        }
    }
}