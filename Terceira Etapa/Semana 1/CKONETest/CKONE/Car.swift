//
//  Car.swift
//  CKONE
//
//  Created by Diego Vidal on 13/04/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import Foundation

protocol Car{
    var id: String? {get}
    var modelName: String {get set}
    var year: UInt {get set}
}
