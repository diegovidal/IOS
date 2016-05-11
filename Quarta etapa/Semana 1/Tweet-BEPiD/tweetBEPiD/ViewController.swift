//
//  ViewController.swift
//  tweetBEPiD
//
//  Created by Eliezio Neto on 20/05/15.
//  Copyright (c) 2015 LearnToProgram.tv. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import AVFoundation
import MediaPlayer

//New random
extension Int {
    func random() -> Int {
        return Int(arc4random_uniform(UInt32(abs(self))))
    }
}

extension Array {
    func sample() -> T {
        let randomIndex = random().random() % count
        return self[randomIndex]
    }
}

class ViewController: UIViewController, UITextFieldDelegate, MCBrowserViewControllerDelegate, MCSessionDelegate, MPMediaPickerControllerDelegate, NSStreamDelegate {
    
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let chatView = UITextView()
        let chatViewBack = UIView()
        let chatTextField = UITextField()
        
        let browseButton = UIButton()
        let musicButton = UIButton()
        
        let serviceType = "dance-party"
        var browser : MCBrowserViewController!
        var assistant : MCAdvertiserAssistant!
        var session : MCSession!
        var peerID: MCPeerID!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            updateMessage()
            self.navigationController?.navigationBarHidden = true
            self.view.backgroundColor = UIColor.blackColor()
            
            
            
            chatView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height/1.1)
            chatView.editable = false
            chatView.backgroundColor = UIColor.whiteColor()
            chatView.alpha = 0.7
            
            
            chatTextField.frame = CGRectMake(5, chatView.frame.origin.y+chatView.frame.height+10, screenSize.width-10, 30)
            chatTextField.borderStyle = .RoundedRect
            chatTextField.backgroundColor = UIColor.grayColor()
            
            browseButton.frame = CGRectMake(5, chatTextField.frame.origin.y+chatTextField.frame.height+15, 70, 10)
            browseButton.setTitle("Browse", forState: UIControlState.Normal)
            browseButton.addTarget(self, action: "showBrowser:", forControlEvents: UIControlEvents.TouchUpInside)
            
            musicButton.frame = CGRectMake(5, browseButton.frame.origin.y+browseButton.frame.height+15, 70, 10)
            musicButton.setTitle("Music", forState: UIControlState.Normal)
            musicButton.addTarget(self, action: "addSongs:", forControlEvents: UIControlEvents.TouchUpInside)
            
            textFieldShouldBeginEditing(chatTextField)
            textFieldDidEndEditing(chatTextField)
            
            chatViewBack.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
            chatViewBack.backgroundColor = UIColor.whiteColor()
            let image = UIImageView(image: UIImage(named: "abstract-438a"))
            chatViewBack.addSubview(image)
            
            self.view.addSubview(chatViewBack)
            self.view.addSubview(chatView)
            self.view.addSubview(chatTextField)
            //self.view.addSubview(browseButton)
            //self.view.addSubview(musicButton)
            
            
            
            
            self.peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
            self.session = MCSession(peer: peerID)
            self.session.delegate = self
            
            // create the browser viewcontroller with a unique service name
            self.browser = MCBrowserViewController(serviceType:serviceType,
                session:self.session)
            
            self.browser.delegate = self
            
            self.assistant = MCAdvertiserAssistant(serviceType:serviceType,
                discoveryInfo:nil, session:self.session)
            
            // tell the assistant to start advertising our fabulous chat
            self.assistant.start()
        }
        
        //MARK: - Helper Methods
        
        // This is called to remove the first responder for the text field.
        func resign() {
            self.resignFirstResponder()
        }
        
        //MARK: - Delegate Methods
        // When clicking on the field, use this method.
        func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
            
            
            // Create a button bar for the number pad
            let keyboardDoneButtonView = UIToolbar()
            keyboardDoneButtonView.sizeToFit()
            
            // Setup the buttons to be put in the system.
            let item = UIBarButtonItem(title: "✅", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("sendMessage") )
            let item2 = UIBarButtonItem(title: "❌", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("cancelMessage") )
            let item3 = UIBarButtonItem(title: "🔄", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("updateMessage") )
            let item4 = UIBarButtonItem(title: "⬇", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("dwonMessage") )
            let space = UIBarButtonItem(title: "  |  ", style: UIBarButtonItemStyle.Bordered, target: self, action: nil )
            var toolbarButtons = [item,space,item2,space,item3,space,item4]
            
            //Put the buttons into the ToolBar and display the tool bar
            keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
            textField.inputAccessoryView = keyboardDoneButtonView
            
            return true
        }
        
        // What to do when a user finishes editting
        func textFieldDidEndEditing(textField: UITextField) {
            
            //nothing fancy here, just trigger the resign() method to close the keyboard.
            resign()
        }
        
        
        // Clicking away from the keyboard will remove the keyboard.
        override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
            self.view.endEditing(true)
        }
        
        // called when 'return' key pressed. return NO to ignore.
        // Requires having the text fields using the view controller as the delegate.
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            
            // Sends the keyboard away when pressing the "done" button
            resign()
            return true
            
        }
        
        
        // This triggers the textFieldDidEndEditing method that has the textField within it.
        //  This then triggers the resign() method to remove the keyboard.
        //  We use this in the "done" button action.
        func sendMessage() {
            // Bundle up the text in the message field, and send it off to all
            // connected peers
            if self.chatTextField.text == ""{
                cancelMessage()
                return;
            }

            if RequisitionHelper.testAddTweet(self.chatTextField.text){
            
            let msg = self.chatTextField.text.dataUsingEncoding(NSUTF8StringEncoding,
                allowLossyConversion: false)
            
            var error : NSError?
            
            self.session.sendData(msg, toPeers: self.session.connectedPeers,
                withMode: MCSessionSendDataMode.Unreliable, error: &error)
            
            if error != nil {
                print("Error sending data: \(error?.localizedDescription)")
            }
            updateMessage()
            self.chatTextField.text = ""
            //self.view.endEditing(true)
            }
            updateMessage()

        }
        
        func cancelMessage() {
            // Bundle up the text in the message field, and send it off to all
            // connected peers
            
            self.chatTextField.text = ""
            self.view.endEditing(true)
        }
    
        func updateMessage() {
            // Bundle up the text in the message field, and send it off to all
            // connected peers
            self.chatView.text = ""
            var cont = 0
            var Emoji = [1,2,3,4,5]
            
            let tweets = RequisitionHelper.loadTweets()
            for information in tweets! {
                switch Emoji.sample() {
                    case 1:
                        let message = "\n-\(information.timestamp)-\n\(information.id) <😁> : \(information.message)\n"
                            self.chatView.text =  self.chatView.text+message
                    case 2:
                        let message = "\n-\(information.timestamp)-\n\(information.id) <😂> : \(information.message)\n"
                        self.chatView.text =  self.chatView.text+message
                    case 3:
                        let message = "\n-\(information.timestamp)-\n\(information.id) <😃> : \(information.message)\n"
                        self.chatView.text =  self.chatView.text+message
                    case 4:
                        let message = "\n-\(information.timestamp)-\n\(information.id) <😅> : \(information.message)\n"
                        self.chatView.text =  self.chatView.text+message
                    case 5:
                        let message = "\n-\(information.timestamp)-\n\(information.id) <😈> : \(information.message)\n"
                        self.chatView.text =  self.chatView.text+message
                    default:
                        let message = "\n-\(information.timestamp)-\n\(information.id) <😈> : \(information.message)\n"
                        self.chatView.text =  self.chatView.text+message
                }
            }

        }
        func dwonMessage() {
            // Bundle up the text in the message field, and send it off to all
            // connected peers
            self.view.endEditing(true)
        }
    
        func showBrowser(sender:UIButton!) {
            // Show the browser view controller
            self.presentViewController(self.browser, animated: true, completion: nil)
        }
        
        func addSongs(sender:UIButton!) {
            let picker = MPMediaPickerController(mediaTypes: MPMediaType.Music);
            picker.delegate = self
            self.presentViewController(picker, animated: true, completion: nil)
        }
        
        func mediaPicker(mediaPicker: MPMediaPickerController!, didPickMediaItems mediaItemCollection: MPMediaItemCollection!) {
            self.dismissViewControllerAnimated(true, completion: nil)
            println(mediaItemCollection.items[0].valueForProperty(MPMediaItemPropertyTitle))
            
            let musicUrl: NSURL = mediaItemCollection.items[0].valueForProperty(MPMediaItemPropertyAssetURL) as! NSURL
            let asset: AVURLAsset = AVURLAsset(URL: musicUrl, options: nil)
            let assetOutput = AVAssetReaderTrackOutput(track: asset.tracks[0] as! AVAssetTrack, outputSettings: nil)
            
            var error : NSError?
            println("yo0")
            let assetReader: AVAssetReader = AVAssetReader(asset: asset, error: &error)
            
            if error != nil {
                print("Error asset Reader: \(error?.localizedDescription)")
            }
            
            assetReader.addOutput(assetOutput)
            assetReader.startReading()
            
            let sampleBuffer: CMSampleBufferRef = assetOutput.copyNextSampleBuffer()
            
            var audioBufferList = AudioBufferList(mNumberBuffers: 1, mBuffers: AudioBuffer(mNumberChannels: 0, mDataByteSize: 0, mData: nil))
            var blockBuffer: Unmanaged<CMBlockBuffer>? = nil
            
            //        CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(
            //            sampleBuffer,
            //            nil,
            //            &audioBufferList,
            //            UInt(sizeof(audioBufferList.dynamicType)),
            //            nil,
            //            nil,
            //            UInt32(kCMSampleBufferFlag_AudioBufferList_Assure16ByteAlignment),
            //            &blockBuffer
            //        )
            let stream = session.startStreamWithName("music", toPeer: session.connectedPeers[0] as! MCPeerID, error: &error)
            
            if error != nil {
                print("Error stream: \(error?.localizedDescription)")
            }
            
            for (var i :UInt32 = 0; i < audioBufferList.mNumberBuffers; i++) {
                var audioBuffer = AudioBuffer(mNumberChannels: audioBufferList.mBuffers.mNumberChannels, mDataByteSize: audioBufferList.mBuffers.mDataByteSize, mData: audioBufferList.mBuffers.mData)
                stream.write(UnsafeMutablePointer<UInt8>(audioBuffer.mData), maxLength: Int(audioBuffer.mDataByteSize))
            }
        }
        
        func updateChat(text : String, fromPeer peerID: MCPeerID) {
            // Appends some text to the chat view
            
            // If this peer ID is the local device's peer ID, then show the name
            // as "Me"
            var name : String
            
            switch peerID {
            case self.peerID:
                name = "Me:"
            default:
                name = peerID.displayName
            }

            // Add the name to the message and display it
            let message = "\(name)(😀): \(text)\n"
            UIView.animateWithDuration(0.1, animations: {
                self.chatView.text = self.chatView.text + message
            })
            
        }
        
        func browserViewControllerDidFinish(
            browserViewController: MCBrowserViewController!)  {
                // Called when the browser view controller is dismissed (ie the Done
                // button was tapped)
                
                self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        func browserViewControllerWasCancelled(
            browserViewController: MCBrowserViewController!)  {
                // Called when the browser view controller is cancelled
                
                self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        func session(session: MCSession!, didReceiveData data: NSData!,
            fromPeer peerID: MCPeerID!)  {
                // Called when a peer sends an NSData to us
                
                // This needs to run on the main queue
                dispatch_async(dispatch_get_main_queue()) {
                    var msg = NSString(data: data, encoding: NSUTF8StringEncoding)
                    self.updateChat(msg! as String, fromPeer: peerID)
                }
        }
        
        // The following methods do nothing, but the MCSessionDelegate protocol
        // requires that we implement them.
        func session(session: MCSession!,
            didStartReceivingResourceWithName resourceName: String!,
            fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!)  {
                
                // Called when a peer starts sending a file to us
        }
        
        func session(session: MCSession!,
            didFinishReceivingResourceWithName resourceName: String!,
            fromPeer peerID: MCPeerID!,
            atURL localURL: NSURL!, withError error: NSError!)  {
                // Called when a file has finished transferring from another peer
        }
        
        func session(session: MCSession!, didReceiveStream stream: NSInputStream!,
            withName streamName: String!, fromPeer peerID: MCPeerID!)  {
                // Called when a peer establishes a stream with us
                if streamName == "music" {
                    stream.delegate = self
                    stream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
                    stream.open()
                }
        }
        
        func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
            if eventCode == NSStreamEvent.HasBytesAvailable {
                
            } else if eventCode == NSStreamEvent.EndEncountered {
                
            } else if eventCode == NSStreamEvent.ErrorOccurred {
                
            }
        }
        
        func session(session: MCSession!, peer peerID: MCPeerID!,
            didChangeState state: MCSessionState)  {
                // Called when a connected peer changes state (for example, goes offline)
                
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }

