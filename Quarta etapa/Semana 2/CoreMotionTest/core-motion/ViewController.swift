//
//  ViewController.swift
//  core-motion
//
//  Created by Diego Vidal on 26/05/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var lblEixoX: UILabel!
    @IBOutlet weak var lblEixoY: UILabel!
    @IBOutlet weak var lblEixoZ: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    // Passo 1 - Instanciando o sensor, obs: boa prática utilizar singleton
    let manager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Passo 2 - Verificando disponibilidade do sensor
        if manager.deviceMotionAvailable{
            
            // Passo 3 - setando o intervalo
            manager.deviceMotionUpdateInterval = 1.0/2.0
            
            // Passo 4 - startar leitura dos dados do sensor
            manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (deviceMotion: CMDeviceMotion!, error: NSError!) -> Void in
                
                //Ler dados do sensor
                self.atualizarLabelsAndImage(deviceMotion)
                
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func atualizarLabelsAndImage(deviceMotion: CMDeviceMotion){
        lblEixoX.text = String(format: "%.4f", deviceMotion.gravity.x)
        lblEixoY.text = String(format: "%.4f", deviceMotion.gravity.y)
        lblEixoZ.text = String(format: "%.4f", deviceMotion.gravity.z)
        
        if deviceMotion.gravity.x >= 0.07{
            myImage.image = UIImage(named: "seta_direita")
        }
        else if deviceMotion.gravity.x <= -0.07{
            myImage.image = UIImage(named: "seta_esquerda")
        }
        else if deviceMotion.gravity.y >= 0.07{
            myImage.image = UIImage(named: "seta_cima")
        }
        else if deviceMotion.gravity.y <= -0.07{
            myImage.image = UIImage(named: "seta_baixo")
        }
        else{
            myImage.image = UIImage(named: "bola_preta")
        }
        
        
    }

}

