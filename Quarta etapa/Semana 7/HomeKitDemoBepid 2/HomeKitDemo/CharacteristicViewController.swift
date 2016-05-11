//
//  CharacteristicViewController.swift
//  HomeKitDemo
//
//  Created by Ricardo Torquato Tavares on 30/06/15.
//  Copyright (c) 2015 com.br.bepid. All rights reserved.
//

import UIKit
import HomeKit
import MultipeerConnectivity


class CharacteristicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,MCSessionDelegate, MCBrowserViewControllerDelegate {

    //Outlets
    @IBOutlet var accessoriesTableView : UITableView!
    
    
    var myID: MCPeerID!
    var session: MCSession!
    var browser: MCBrowserViewController!
    var assistent: MCAdvertiserAssistant!
    
    
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
        
        
        myID = MCPeerID(displayName: UIDevice.currentDevice().name)
        session = MCSession(peer: myID)
        session.delegate = self
        browser = MCBrowserViewController(serviceType: "RO", session: session)
        browser.delegate = self
        assistent = MCAdvertiserAssistant(serviceType: "RO", discoveryInfo: nil, session: session)
        assistent.start()
        
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
    
    //MARK: Multipeer
    
    @IBAction func connect(sender: AnyObject) {
        presentViewController(browser, animated: true, completion: nil)
    }
    
    @IBAction func send(sender: UIButton) {
        
    }
    
    // Remote peer changed state
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState){
        switch state{
        case .Connected:
            println("conectado a \(peerID.displayName)")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
            })
        case .Connecting:
            println("conectando a \(peerID.displayName)")
        case .NotConnected:
            println("desconectado a \(peerID.displayName)")
        default:
            break
        }
    }
    
    // Received data from remote peer
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!){
        if let receiveString = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? String{
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                println("\(receiveString) recebido")
                var valor: Bool!
                if receiveString == "false"{
                    valor = false
                }else{
                    valor = true
                }
                let object = self.characteristics[1] as HMCharacteristic
                if (object.value != nil) {
                    object.writeValue(valor, completionHandler:
                        {
                            (error:NSError!) in
                            if (error != nil) {
                                NSLog("Change Char Error: \(error)")
                            }else{
                                dispatch_async(dispatch_get_main_queue(),
                                    {
//                                        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
//                                            cell.textLabel?.text = "\(object.value)"
//                                        }
                                    }
                                )
                            }
                        }
                    )}
            })
        }
    }
    
    // Received a byte stream from remote peer
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!){
    }
    
    // Start receiving a resource from remote peer
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!){}
    
    // Finished receiving a resource from remote peer and saved the content in a temporary location - the app is responsible for moving the file to a permanent location within its sandbox
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!){}
    
    
    //MARK: Browser
    
    // Notifies the delegate, when the user taps the done button
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!){
        browser.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Notifies delegate that the user taps the cancel button.
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!){
        browser.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

}
