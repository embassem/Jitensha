//
//  ViewControllers.swift
//  Jitensha
//
//  Created by Bassem Abbas on 6/7/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import Foundation
import UIKit
class ViewControllers {

// we prefear too send appDelegate as a Paramter and not to use AppDelegate GlobalVariable or UIApplication Extension 
// as a common Patern for Multi use in otherProject and Not passing extension  to other Project
// did n't have a chance to discuss pattern with other Developers  . All Roads Lead to Rome.
    
    class func setClientMainView (application:AppDelegate)
    {
        let stb                                = UIStoryboard(storyboard: .Main);
        let mainViewController:MapViewController                 = stb.instantiateViewController()
        let mapVM = MapViewModel();
        mainViewController.viewModel = mapVM;
        application.window?.rootViewController = mainViewController
        application.window?.makeKeyAndVisible()


    }


    class func SetClientLoginView(application:AppDelegate){

        let stb                                = UIStoryboard(storyboard: .Auth)
        let loginNav                           = stb.instantiateInitialViewController();
       if let loginVC =   loginNav?.childViewControllers.first as? LoginViewController {
        
        loginVC.viewModel = AuthViewModel();
            
        }
        application.window!.rootViewController = loginNav;
        application.window?.makeKeyAndVisible();



    }


    class func completeLogin(loginResponse:LoginResponse){
        
        
        // Do any related work with user Login  like get User Object or get current State for user
        Helper.Authorize.updateLoginResponse(loginResponse)
        
        ClientService.shared.newInstance();
        ViewControllers.setClientMainView(application: APP_DELEGATE);
        
        
    }

    class func registerViewController(authViewModel:AuthViewModel? = nil) -> RegisterViewController {
        
        var viewModel = authViewModel;
        if (viewModel == nil)
        {
            viewModel = AuthViewModel();
        }
        let stb                                = UIStoryboard(storyboard: .Auth)
        let registerVC: RegisterViewController = stb.instantiateViewController()
        registerVC.viewModel = viewModel;
       
        return registerVC
        
    }


    class func rentViewController(mapViewModel:MapViewModel) -> RentViewController {
        
        
       
        let stb                                = UIStoryboard(storyboard: .Main)
        let rentVC: RentViewController = stb.instantiateViewController()
        rentVC.viewModel = mapViewModel;
        
        return rentVC
        
    }




}
