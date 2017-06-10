//
//  Config.swift
//  Jitensha
//
//  Created by Bassem Abbas on 6/7/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import Foundation

import Foundation
import CoreLocation

let apibaseUrl = "http://192.168.1.45:8080"


struct Config {
    
    static let GOOGLE_MAP_API_KEY = "AIzaSyBcX4HmvJ2exAwELQ7Uo5CQxJ2X_ZFPY5c";
  
     
    static let GOOGLE_MAP_INITIAL_LOCATION:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.7574465, longitude: 139.6833125)
    
    
    static let GOOGLE_MAP_INITIAL_ZOME:Float = 6.0;
    
    
    static let LOCATION_SERVICE_FILTER_DISTANCE = 50.0;
    static let LOCATION_SERVICE_ACCURACY = kCLLocationAccuracyBest
    
    
}
