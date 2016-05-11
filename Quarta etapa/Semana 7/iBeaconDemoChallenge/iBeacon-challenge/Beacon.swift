//
//  Beacon.swift
//  iBeacon-challenge
//
//  Created by Diego Vidal on 26/06/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class Beacon: NSObject {
   
    var nome : String
    var major: NSNumber
    
    init(nome: String, major: NSNumber){
        self.nome = nome
        self.major = major
    }
    
}
