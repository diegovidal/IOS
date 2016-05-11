//
//  ViewController.swift
//  AVAudioRecord-Test
//
//  Created by Diego Vidal on 18/08/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var recordOutlet: UIButton!
    @IBOutlet weak var stopOutlet: UIButton!
    @IBOutlet weak var playOutlet: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playOutlet.enabled = false
        stopOutlet.enabled = false
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths.first as! String
        let soundFilePath = docsDir.stringByAppendingPathComponent("sound.caf")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue, AVEncoderBitRateKey: 16, AVNumberOfChannelsKey:2, AVSampleRateKey: 44100.0]
        
        var error: NSError?
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        
        if let err = error{
            println("audioSession error: \(err.localizedDescription)")
        }
        
        audioRecorder = AVAudioRecorder(URL: soundFileURL, settings: recordSettings as! [NSObject: AnyObject], error: &error)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAction(sender: UIButton) {
        if audioRecorder?.recording == false{
            playOutlet.enabled = false
            stopOutlet.enabled = true
            audioRecorder?.record()
        }
    }

    @IBAction func stopAction(sender: UIButton) {
        stopOutlet.enabled = false
        playOutlet.enabled = true
        recordOutlet.enabled = true
        
        if audioRecorder?.recording == true{
            audioRecorder?.stop()
        }
        else{
            audioPlayer?.stop()
        }
    }
    
    @IBAction func playAction(sender: UIButton) {
        if audioRecorder?.recording == false{
            stopOutlet.enabled = true
            recordOutlet.enabled = false
        }
        
        var error: NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder?.url, error: &error)
        
        if let err = error{
            println("audioPlayer error: \(error?.localizedDescription)")
        }
        else{
            audioPlayer?.play()
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        recordOutlet.enabled = true
        stopOutlet.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("audio play decode error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        println("audio recorder encode error")
    }
    
}

