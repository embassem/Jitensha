//
//  TokenPlugin.swift
//  Jitensha
//
//  Created by Bassem Abbas on 6/7/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import Foundation
import Moya
public struct TokenPlugin: PluginType {
    
    /// The access token to be applied in the header.
    public let token: String
    
    private var authVal: String {
        return  token
    }
    
    /**
     Initialize a new `TokenPlugin`.
     
     - parameters:
     - token: The token to be applied in the pattern `Authorization: Bearer <token>`
     */
    public init(token: String) {
        self.token = token
    }
    
    /**
     Prepare a request by adding an authorization header if necessary.
     
     - parameters:
     - request: The request to modify.
     - target: The target of the request.
     - returns: The modified `URLRequest`.
     */
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let authorizable = target as? AccessTokenAuthorizable, authorizable.shouldAuthorize == false {
            return request
        }
        
        var request = request
        request.addValue(authVal, forHTTPHeaderField: "Authorization")
        
        return request
    }
}
