//
//  AddAccessoriesViewController.swift
//  HomeKitDemo
//
//  Created by Ricardo Torquato Tavares on 30/06/15.
//  Copyright (c) 2015 com.br.bepid. All rights reserved.
//

import UIKit
import HomeKit
//protoloco HMAccessoryBrowserDelegate
//...
class AddAccessoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HMAccessoryBrowserDelegate{
    
    //Outlets
    @IBOutlet var accessoriesTableView : UITableView!
    
    //Actions
    @IBAction func dismissAddAccessories(sender : AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Homekit
    //Declaramos accessoriesBrowser (HMAccessoryBrowser) e Array de acessorios(HMAccessory)
    //...
    
    var accessories = [HMAccessory]()
    let accessoriesBrowser: HMAccessoryBrowser = HMAccessoryBrowser()

    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate accessoriesBrowser
        //...
        accessoriesBrowser.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        //iniciar a procura (startSearchingForNewAccessories)
        //...
        accessoriesBrowser.startSearchingForNewAccessories()
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        super.viewDidDisappear(animated)
        //parar a procura (stopSearchingForNewAccessories)
        //...
        accessoriesBrowser.stopSearchingForNewAccessories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
     //MARK: - TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessories.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = accessories[indexPath.row].name
        
        return cell
    }

    //adicionando acessorio na casa (Obserção:...)
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
     //...
        CoreHome.sharedInstance.homePrimary?.addAccessory(accessories[indexPath.row], completionHandler: { (error:NSError!) -> Void in
            //
            if error != nil{
                NSLog("\(error)")
            }
        })
    }
    
     //MARK: - HomeKit Accessory
    func accessoryBrowser(browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory!)
    {
        if !contains(accessories, accessory) {
            accessories.insert(accessory, atIndex: 0)
             accessoriesTableView.insertRowsAtIndexPaths([NSIndexPath(forRow:0, inSection:0)], withRowAnimation: .Automatic)
        }
    }
    
    func accessoryBrowser(browser: HMAccessoryBrowser, didRemoveNewAccessory accessory: HMAccessory!)
    {
        if let index = find(accessories, accessory) {
            accessories.removeAtIndex(index)
            accessoriesTableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Fade)
        }
    }
   

}
