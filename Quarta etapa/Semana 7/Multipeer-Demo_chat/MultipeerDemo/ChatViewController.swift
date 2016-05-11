//
//  ChatViewController.swift
//  MultipeerDemo
//
//  Created by Diego Vidal on 30/06/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ChatViewController: ResponsiveTextFieldViewController, UITableViewDelegate, UITableViewDataSource, MCSessionDelegate, MCBrowserViewControllerDelegate, NSStreamDelegate {
    
    var myID: MCPeerID!
    var session : MCSession!
    var browser: MCBrowserViewController!
    var assistant: MCAdvertiserAssistant!
    
    var outputStream: NSOutputStream!
    var inputStream: NSInputStream!
    var comments: [String] = Array()
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return comments.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = comments[indexPath.row]
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setup(){
        myID = MCPeerID(displayName: UIDevice.currentDevice().name)
        session = MCSession(peer: myID)
        session.delegate = self
        
        browser = MCBrowserViewController(serviceType: "Vidal", session: session)
        browser.delegate = self
        
        assistant = MCAdvertiserAssistant(serviceType: "Vidal", discoveryInfo: nil, session: session)
        assistant.start()
    }
    
    @IBAction func findPeers() {
        presentViewController(browser, animated: true, completion: nil)
    }
    
    @IBAction func sendText() {
        let stringData = NSKeyedArchiver.archivedDataWithRootObject(self.commentTextField.text)
        session.sendData(stringData, toPeers: session.connectedPeers, withMode: .Reliable, error: nil)
        self.comments.append(self.commentTextField.text)
        self.chatTableView.reloadData()
        
    }
    
    //MARK: SessionDelegate
    
    // Remote peer changed state
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState){
        switch state{
        case .Connected:
            println("Conectado a \(peerID.displayName)")
        case .Connecting:
            println("Conectando a \(peerID.displayName)")
        case .NotConnected:
            println("Desconectado de \(peerID.displayName)")
        default:
            break
        }
        
    }
    
    // Received data from remote peer
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!){
        if let frase = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? String{
            println(frase)
            comments.append(frase)
            self.chatTableView.reloadData()
        }
    }
    
    // Received a byte stream from remote peer
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!){
        println("Stream received")
        self.inputStream = stream
        self.inputStream.scheduleInRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        self.inputStream.delegate = self
        self.inputStream.open()
    }
    
    // Start receiving a resource from remote peer
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!){
        println("\(resourceName) começou a ser recebido")
    }
    
    // Finished receiving a resource from remote peer and saved the content in a temporary location - the app is responsible for moving the file to a permanent location within its sandbox
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!){
        
    }
    
    //MARK: BrowserViewControllerDelegate
    
    // Notifies the delegate, when the user taps the done button
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!){
        browser.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Notifies delegate that the user taps the cancel button.
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!){
        browser.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Stream Delegate
    
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        switch eventCode{
        case NSStreamEvent.HasBytesAvailable:
            if let inputStream = aStream as? NSInputStream{
                var buffer = Array<UInt8>(count: 1024, repeatedValue: 0)
                let numberBytes = inputStream.read(&buffer, maxLength: 1024)
                let dataString = NSData(bytes: &buffer, length: numberBytes)
                if let message = NSKeyedUnarchiver.unarchiveObjectWithData(dataString) as? String{
                    println(message)
                }
            }
            break
        default:
            break
        }
    }

}
