//
//  Helper_Authorize.swift
//  GooTaxiClient
//
//  Created by Bassem Abbas on 4/28/17.
//  Copyright © 2017 ADLANC. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper
import SwiftyJSON

extension Helper {



    class Authorize {



        static var loginResponse: LoginResponse? {

            get {

                return self.getLoginResponse();
            }

        }

        class func logOutUser() {

            AppDefaultsAuthorized.removeObject(forKey: AppUserDefaults.AccessToken.rawValue)
            AppDefaultsAuthorized.synchronize();
            APP_DELEGATE.InitCorrectView();
        }


        class func updateLoginResponse( _ loginResponse: LoginResponse)
        {
            let loginResponseString = Mapper().toJSONString(loginResponse, prettyPrint: false)
            AppDefaultsAuthorized.set(loginResponseString!, forKey: AppUserDefaults.AccessToken.rawValue);
            AppDefaultsAuthorized.synchronize()
            print(loginResponse);
        }

        fileprivate class func getLoginResponse() -> (LoginResponse?)
        {
            if let UserSettingObj   = AppDefaultsAuthorized.object(forKey: AppUserDefaults.AccessToken.rawValue) as? String {
            let jsonObj: JSON       = JSON(UserSettingObj)
            let UserObject          = Mapper<LoginResponse>().map(JSONString: jsonObj.rawString()!);
                // print(UserObject?.userName);
                return UserObject;
            }

            return nil;

        }



    }



}
