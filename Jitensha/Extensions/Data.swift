//
//  Data.swift
//
//  Created by Bassem Abbas on 5/1/17.
//  Copyright © 2017 ADLANC. All rights reserved.
//

import Foundation
import SwiftyJSON



extension Data{
    
    func toJSON() -> JSON? {
        if self != nil {
            
            let json = JSON(data: self);
            return json;
        }else {
            
            return nil;
        }
        
    }
    
}
