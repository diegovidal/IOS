//
//  ViewController.swift
//  audioDemo
//
//  Created by Diego Vidal on 18/08/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSBundle.mainBundle().URLForResource("BackToReality01", withExtension: "mp3")
        var error: NSError?
        
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        if let err = error{
            println("audioPlayer Error: \(err.localizedDescription)")
        }
        else{
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playAudio(sender: UIButton) {
        if let music = audioPlayer{
            music.play()
        }
    }

    @IBAction func stopAudio(sender: UIButton) {
        if let music = audioPlayer{
            music.stop()
        }
        
    }
    
    @IBAction func adjustVolume(sender: UISlider) {
        if let music = audioPlayer{
            music.volume = sender.value
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("Encerrou a execução do audio")
    }
}

