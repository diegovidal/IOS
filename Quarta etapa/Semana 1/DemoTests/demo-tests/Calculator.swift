//
//  Calculator.swift
//  demo-tests
//
//  Created by Diego Vidal on 19/05/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class Calculator: NSObject {
  
    class func sumA(a: Double, toB b:Double) -> Double{
        return a + b
    }
    
    class func subtract(a: Double, fromB b:Double) -> Double{
        return a - b
    }
   
    class func multiplyA(a:Double, withB b:Double) -> Double{
        return a * b
    }
    
    class func divideA(a: Double, byB b:Double) -> Double{
        return a / b
    }
}
