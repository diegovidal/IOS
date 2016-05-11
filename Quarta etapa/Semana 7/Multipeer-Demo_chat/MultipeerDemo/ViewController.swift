//
//  ViewController.swift
//  MultipeerDemo
//
//  Created by gustavo on 6/24/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate, NSStreamDelegate {
    
    @IBOutlet weak var sendTextButton: UIButton!
    @IBOutlet weak var sendStreamButton: UIButton!
    @IBOutlet weak var sendResourceButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var myID: MCPeerID!
    var session : MCSession!
    var browser: MCBrowserViewController!
    var assistant: MCAdvertiserAssistant!
    
    var outputStream: NSOutputStream!
    var inputStream: NSInputStream!
    var comments: [String] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
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
        let stringData = NSKeyedArchiver.archivedDataWithRootObject("String received using SendData")
        session.sendData(stringData, toPeers: session.connectedPeers, withMode: .Reliable, error: nil)
        
    }
    
    @IBAction func sendOverStream() {
        if outputStream == nil{
            outputStream = session.startStreamWithName("textStream", toPeer: session.connectedPeers.first as! MCPeerID, error: nil)
        
        outputStream.scheduleInRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        outputStream.open()
        sendStreamButton.setTitle("Send over stream.", forState: .Normal)
        }
        else {
            let message = "String sent using NSStream"
            let stringData = NSKeyedArchiver.archivedDataWithRootObject(message)
            
            outputStream.write(UnsafePointer(stringData.bytes), maxLength: stringData.length)
        }

    }
    
    @IBAction func sendImage() {
        let path = NSBundle.mainBundle().pathForResource("goat", ofType: "jpg")
        if let imageURL = NSURL(fileURLWithPath: path!){
            session.sendResourceAtURL(imageURL, withName: "Cabritinha", toPeer: session.connectedPeers.first as! MCPeerID, withCompletionHandler: { (erro) -> Void in
                if erro != nil{
                    println("Deu tudo errado")
                }
                else{
                    println("Deu tudo certo")
                }
            })
        }
    }
    
    //MARK: SessionDelegate
    
    // Remote peer changed state
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState){
        switch state{
        case .Connected:
            println("Conectado a \(peerID.displayName)")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.sendTextButton.enabled = true
                self.sendStreamButton.enabled = true
                self.sendResourceButton.enabled = true
            })
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
        println()
        let img = CIImage(contentsOfURL: localURL)
        let image = UIImage(CIImage: img)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.imageView.image = image
        })
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

    @IBAction func goToChat(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("segueChat", sender: comments)
    }
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let chatTableView: ChatViewController = segue.destinationViewController as! ChatViewController
    }
    
}

