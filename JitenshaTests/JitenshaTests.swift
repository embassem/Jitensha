//
//  JitenshaTests.swift
//  JitenshaTests
//
//  Created by Bassem Abbas on 6/7/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import XCTest
@testable import Jitensha

class JitenshaTests: XCTestCase {
    
    var mapVM:MapViewModel!
    override func setUp() {
        super.setUp()
        
        mapVM = MapViewModel();
       
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }
    
    
//    func testLogin(){
//        let login = AuthModel(email: "crossover@ibtikar.net.sa", password: "crossover")
//        authVm.procideLoginProcess(loginModel: login);
//        
//    }
    
    
    func testLoadPlaces(){
        // to uncomment  loadPlaces() commecnt it in MapViewController
       // mapVM.loadPlaces()
        
        var promise = expectation(description: "data  Places")
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "getPlaces"), object: nil, queue: nil) { (notification) in
            
            guard let results = notification.object as? PlacesResponse else {
                
        
             
                XCTFail("data Not returned")
                return
                
            }
            
            promise.fulfill()
             return
            
        }

    
        
         waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    
    func testRent(){
        
        
        var promise = expectation(description: "data Rent Place")
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "didRentPlace"), object: nil, queue: nil) { (notification) in
            
            guard let result = notification.object as? String else {
                
                XCTFail("data Not returned Rent API")
                
                return
                
            }
            
            if (result.isEmpty){
                XCTAssert(false, "Rent Failed \(result)")

                XCTFail("operation Failed Rent API")
            }else {
                XCTAssert(true, "Rent Success \(result)")
                promise.fulfill()
            }
            
            return
            
        }
        mapVM.currentPlace = Result();
        mapVM.rentCurrentPlace(cardHolder: "Crossover", cardNumber: "4105603867235712", cardExpiry: "11/22", cardCode: "123")
        

        
        waitForExpectations(timeout: 10, handler: nil)
    }
    

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
