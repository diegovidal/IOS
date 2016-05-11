//
//  CalculatorTest.swift
//  demo-tests
//
//  Created by Diego Vidal on 19/05/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit
import XCTest

class CalculatorTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // Quando se trata de Double, aconselha-se utilizar CTAssertEqualWithAccuracy por causa da imprecisão
    func testSum(){
//        let result = Calculator.sumA(4.0, toB: 5.5)
//        XCTAssertTrue(result == 9.5, "Teste Falhou")
        
//        let result = Calculator.sumA(4.0, toB: 5.5)
//        XCTAssertEqual(result, 9.5, "Teste falhou")
        
        let result = Calculator.sumA(4.0, toB: 5.5)
        XCTAssertEqualWithAccuracy(result, 9.5, 0.001, "Teste Falhou")
        
        
    }
    
    func testSubtract(){
        var result = Calculator.subtract(2.0, fromB: 4.0)
        XCTAssertEqualWithAccuracy(result, -2.0, 0.001, "Teste Falhou")
    }
    
    func testDivision(){
        var result = Calculator.divideA(10.0, byB: 2.0)
        XCTAssertEqualWithAccuracy(result, 5.0, 0.001, "Teste Falhou")
        
        result = Calculator.divideA(10.0, byB: 0.0)
        XCTAssertEqual(result, Double.infinity, "Teste Falhou")
    }

}
