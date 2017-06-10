//
//  LoginViewModel.swift
//  Jitensha
//
//  Created by Bassem Abbas on 6/8/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import Foundation

class AuthViewModel {
    
    
    
    init() {
        
    }
    
    
    func procideLoginProcess(loginModel:AuthModel) -> Void {
        
        Shared.HUD.progressHUD(nil, message: "LOGIN".localized());

        ClientService.shared.login(loginModel: loginModel) { (json, model, response) in
            Shared.HUD.hide();
            if (response?.statusCode == 400 || response?.statusCode == 401){
                //bad request
                if let basemodel = model as? BaseModel {
                    
                    Shared.AlertDialog.alertWithDismiss("Error", message: basemodel.message, image: nil, cancelTitleKey: "ok");
                    
                    
                    
                }
                
                
            }else if (response?.statusCode == 200){
                //login sussecc
                
                
                if let loginResponse = model as? LoginResponse {
                    
                    ViewControllers.completeLogin(loginResponse: loginResponse);
                }
                
            }else {
                if let basemodel = model as? BaseModel {
                    
                    Shared.AlertDialog.alertWithDismiss("Error", message: basemodel.message, image: nil, cancelTitleKey: "ok");
                    
                    
                    
                }
                
            }
            
            
        }
        
        
    }
    
    
    func registerUser(registerModel:AuthModel) -> Void {
        
        Shared.HUD.progressHUD(nil, message: "Register".localized());
        
        ClientService.shared.register(registerModel: registerModel, delegate: { (json, model, response) in
            Shared.HUD.hide();
            if (response?.statusCode == 400 || response?.statusCode == 401){
                //bad request
                if let basemodel = model as? BaseModel {
                    
                    Shared.AlertDialog.alertWithDismiss("Error", message: basemodel.message, image: nil, cancelTitleKey: "ok");
                    
                    
                    
                }
                
                
            }else if (response?.statusCode == 200){
                //login sussecc
                
                
                if let loginResponse = model as? LoginResponse {
                    
                    ViewControllers.completeLogin(loginResponse: loginResponse);
                }
                
            }else {
                if let basemodel = model as? BaseModel {
                    
                    Shared.AlertDialog.alertWithDismiss("Error", message: basemodel.message, image: nil, cancelTitleKey: "ok");
                    
                    
                    
                }
                
            }
            
            
        })
        
        
    }
    
    
    

    
    
    
}
