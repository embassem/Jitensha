//
//  MapViewModel.swift
//  Jitensha
//
//  Created by Bassem Abbas on 6/8/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import Foundation

class MapViewModel {
    
    
    
    init() {
        
    }
    var currentPlace:Result?
    
    
    func loadPlaces()  {
        
        ClientService.shared.places(delegate:  { (json, model, response) in
            Shared.HUD.hide();
            if (response?.statusCode == 400 || response?.statusCode == 401){
                //bad request
                if let basemodel = model as? BaseModel {
                    
                    Shared.AlertDialog.alertWithDismiss("Error", message: basemodel.message, image: nil, cancelTitleKey: "ok");
                    
                    
                    
                }
                
                
            }
            else if (response?.statusCode == 200){
                //login sussecc
                
                
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getPlaces"), object: model)

 
            }
            else {
                if let basemodel = model as? BaseModel {
                    
                    Shared.AlertDialog.alertWithDismiss("Error", message: basemodel.message, image: nil, cancelTitleKey: "ok");
                    
                    
                    
                }
                
            }
            
            
        })
    }
    
    
    func rentCurrentPlace(cardHolder:String,cardNumber:String,cardExpiry:String,cardCode:String){
        
        guard let place = currentPlace  else {
            
            assert(false, "try to rent placewith no place ");
            return
            }
        // service didn't accept place id in paramter
        debugPrint(place)
        
        let rentmodel = RentModel(code: cardCode, expiration: cardExpiry, name: cardHolder, number: cardNumber);
        ClientService.shared.rent(rentModel: rentmodel, delegate:  { (json, model, response) in
            Shared.HUD.hide();
            if (response?.statusCode == 400 || response?.statusCode == 401){
                //bad request
                if let basemodel = model as? BaseModel {
                    
                    Shared.AlertDialog.alertWithDismiss("Error", message: basemodel.message, image: nil, cancelTitleKey: "ok");
                    
                    
                    
                }
                
                
            }
            else if (response?.statusCode == 200){
                //login sussecc
                
                guard let baseModel = model as? BaseModel else {
                    
                    return
                }
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didRentPlace"), object: baseModel.message!)
                
                
            }
            else {
                if let basemodel = model as? BaseModel {
                    
                    Shared.AlertDialog.alertWithDismiss("Error", message: basemodel.message, image: nil, cancelTitleKey: "ok");
                    
                    
                    
                }
                
            }
            
            
        })

        
    }
        
    
    
    
}
