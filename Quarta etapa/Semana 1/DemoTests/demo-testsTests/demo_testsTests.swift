//
//  demo_testsTests.swift
//  demo-testsTests
//
//  Created by Diego Vidal on 19/05/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit
import XCTest

class demo_testsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // Para ser uma função de teste precisa começar com o nome test, retorno void e sem parâmetros
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
