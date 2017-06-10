//
//  ClientService.swift
//  Jitensha
//
//  Created by Bassem Abbas on 6/7/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//


import Foundation
import Moya
import Moya_ObjectMapper
import Alamofire


class ClientProvider:NSObject {
    
    private let baseUrl:String!
    
    var provider : MoyaProvider<ClientAPI>!
    
    init(serverUrl:String) {
        self.baseUrl = serverUrl;
    
    
//  let endpointClosure = { (target: ClientAPI) -> Endpoint<ClientAPI> in
//        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
//    //adding(newParameterEncoding:JSONEncoding.default).adding(newHTTPHeaderFields: ["Authorization" : accessToken])
//    if let  loginResponce:LoginResponse = Helper.Authorize.loginResponse {
//        
//        let accessToken = "\(loginResponce.tokenType!) \(loginResponce.accessToken!)"
//        return defaultEndpoint.adding(newHTTPHeaderFields: ["Authorization": accessToken])
//    }else {
//        return defaultEndpoint;
//    }
//   
//    }
        
//     self.provider = MoyaProvider<ClientAPI>(endpointClosure: endpointClosure,plugins:[NetworkLoggerPlugin(verbose: true ,responseDataFormatter: JSONResponseDataFormatter)])
        
        
    
        if let accesstoken = Helper.Authorize.loginResponse?.accessToken{
            
            self.provider =  MoyaProvider<ClientAPI>(plugins: [TokenPlugin(token:accesstoken) ,NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
            
        }else {
            
             self.provider =  MoyaProvider<ClientAPI>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
            
        }
        
       
        

    
    }
    
    
    
    
    
}



 enum ClientAPI {
    
    case auth(loginModel:AuthModel)
    case register(registerModel:AuthModel)
    case places()
    case rent(rentModel:RentModel)
    
    
    
}




extension ClientAPI:TargetType, AccessTokenAuthorizable{
    
    
    
    /*
     TargetType implementation
     */
    
    var shouldAuthorize: Bool {
        switch self {
        case .places(),.rent(rentModel: _):
            return true
        case .auth(_),.register(_):
            return false
        }
    }
    
    /// The target's base `URL`.
    public var baseURL: URL {  return URL(string: apibaseUrl)! }
    
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        
        switch self {
            
        case .auth(_):
            
            return "/api/v1/auth"
            
        case .register(_):
            
            return "/api/v1/register"
            
            
        case .places():
            return "/api/v1/places"
            
        case .rent(_):
            return "/api/v1/rent"
            
            
                }
       
        
        
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
    
        switch self {
        case .places():
            return .get
            
        default:
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
    
        switch self {
         
        case .auth(loginModel: let model):
            
            return model.toJSON();
            
        case .register(registerModel: let model):
            
            
            return model.toJSON();
     
            
        case .places():
            return nil
        case .rent(rentModel: let model):
            return model.toJSON()

       
        }
      
    }
    
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
    
        switch self {
            
              default:
            return JSONEncoding.default
        }

    }
    
    /// Provides stub data for use in testing.
    public var sampleData: Data {
        switch self {
        
        default:
            return "".data(using: String.Encoding.utf8)!
        }

    }
    
    /// The type of HTTP task to be performed.
    public var task: Task {
    
        switch self {
      
        default:
            return .request
        }

    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    public var validate: Bool {
    
        switch self {
        
        default:
            return true
        }

    
    }
    
    
    
    
}


// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}


// MARK: - Provider support



private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}


