//
//  JitenshaUITests.swift
//  JitenshaUITests
//
//  Created by Bassem Abbas on 6/7/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import XCTest
@testable
import Jitensha

class JitenshaUITests: XCTestCase {
    
    var app :XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        app =  XCUIApplication();
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogin() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        
        
        let emailTextField = app.textFields["Email"]
        
        emailTextField.tap()
        
        app.buttons["Login"].tap()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testRent(){
        
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).tap()
        app.buttons["Rent"].tap()
        
        
    }
    
}
