//
//  LabelViewController.swift
//  core-motion
//
//  Created by Diego Vidal on 27/05/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit
import CoreMotion

class LabelViewController: UIViewController {

    @IBOutlet weak var lblEixoX: UILabel!
    @IBOutlet weak var lblEixoY: UILabel!
    @IBOutlet weak var lblEixoZ: UILabel!
    
    @IBOutlet weak var turn: UILabel!
    
    let manager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Passo 2 - Verificando disponibilidade do sensor
        if manager.deviceMotionAvailable{
            
            // Passo 3 - setando o intervalo
            manager.deviceMotionUpdateInterval = 0.01
            
            // Passo 4 - startar leitura dos dados do sensor
            manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (deviceMotion: CMDeviceMotion!, error: NSError!) -> Void in
                
                //Ler dados do sensor
                self.atualizaRotateLabelWithSensorFusion(deviceMotion)
                
            })

//            manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (accelerometer: CMAccelerometerData!, error: NSError!) -> Void in
//                
//                //Ler dados do sensor
//                self.atualizaRotateLabelWithAccelerometer(accelerometer)
//            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Uitilizando sensorFusion
    func atualizaRotateLabelWithSensorFusion(deviceMotion: CMDeviceMotion){
        lblEixoX.text = String(format: "%.4f", deviceMotion.gravity.x)
        lblEixoY.text = String(format: "%.4f", deviceMotion.gravity.y)
        lblEixoZ.text = String(format: "%.4f", deviceMotion.gravity.z)
        
        var x = -deviceMotion.gravity.x
        var y = -deviceMotion.gravity.y
        var angle :Double = atan2(x, y)
        
        turn.transform = CGAffineTransformMakeRotation(CGFloat(angle))
        
        if deviceMotion.gravity.y >= 0.95 || deviceMotion.gravity.y <= -0.95{
            turn.text = "Portrait"
        }
        else if deviceMotion.gravity.x >= 0.95 || deviceMotion.gravity.x <= -0.95{
            turn.text = "Landscape"
        }
    }
    
    // Uitilizando Acelerômetro
    func atualizaRotateLabelWithAccelerometer(accelerometer: CMAccelerometerData){
        
        lblEixoX.text = String(format: "%.4f", accelerometer.acceleration.x)
        lblEixoY.text = String(format: "%.4f", accelerometer.acceleration.y)
        lblEixoZ.text = String(format: "%.4f", accelerometer.acceleration.z)
        
        var x = -accelerometer.acceleration.x
        var y = -accelerometer.acceleration.y
        var angle :Double = atan2(x, y)
        
        turn.transform = CGAffineTransformMakeRotation(CGFloat(angle))
        
        if accelerometer.acceleration.y >= 0.95 || accelerometer.acceleration.y <= -0.95{
            turn.text = "Portrait"
        }
        else if accelerometer.acceleration.x >= 0.95 || accelerometer.acceleration.x <= -0.95{
            turn.text = "Landscape"
        }
    
    }


}
