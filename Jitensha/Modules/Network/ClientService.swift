//
//  ClientService.swift
//  Jitensha
//
//  Created by Bassem Abbas on 6/7/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import SwiftyJSON
import Moya_ObjectMapper


//protocol ClientServiceDelegate {
//    func didGetResponseorEndPoint(data:JSON?,model:Mappable?,response:HTTPURLResponse?);
//}
typealias ServiceResponse = (_ data: JSON?, _ model: Mappable?, _ response: Response?) -> Void;

class ClientService: NSObject {

    static let shared: ClientService = {
        let instance = ClientService()
        return instance
    }()

    func newInstance (){
        // neasesary for recreate provider after login to cttach accesstoken to it.
        self.APIProvider = ClientProvider(serverUrl: apibaseUrl).provider!
    }
    
    private var APIProvider = ClientProvider(serverUrl: apibaseUrl).provider!;


    func login(loginModel: AuthModel, delegate: @escaping ServiceResponse) -> Void {

        APIProvider.request(ClientAPI.auth(loginModel: loginModel)) { moyaResponse in

            var json: JSON? = nil;
            var model: Mappable? = nil;

            switch moyaResponse {
            case let .success(response):

                do {

                    let data = moyaResponse.value?.data
                    json = JSON(data: data!);
                    model = try response.mapObject(LoginResponse.self)


                } catch {

                    debugPrint("Failed to parse Login Response to Model")
                }

                delegate(json, model, response)

                break

            case let .failure(error):

                debugPrint("URL: \(error.response?.request?.url?.description ?? "login>>")   Response : \(String(describing: error.response?.data.toJSON()?.description))", error, error.localizedDescription);

                do {
                    model = try error.response?.mapObject(BaseModel.self);
                    if let respoData = error.response?.data {
                        json = JSON(data: respoData);
                    }
                }
                catch {

                }
                if model == nil {
                    let base = self.globalErrorHandler(error: error);
                    model = base;
                }
                
                delegate(json, model, error.response);

            }


        }

    }

    func register(registerModel: AuthModel, delegate: @escaping ServiceResponse) -> Void {

        APIProvider.request(ClientAPI.register(registerModel: registerModel)) { moyaResponse in

            var json: JSON? = nil;
            var model: Mappable? = nil;

            switch moyaResponse {
            case let .success(response):

                do {

                    let data = moyaResponse.value?.data
                    json = JSON(data: data!);
                    model = try response.mapObject(LoginResponse.self)


                } catch {

                    debugPrint("Failed to parse register Response to Model")
                }

                delegate(json, model, response)

                break

            case let .failure(error):

                debugPrint("URL: \(error.response?.request?.url?.description ?? "register>>")   Response : \(String(describing: error.response?.data.toJSON()?.description))", error, error.localizedDescription);

                do {
                    model = try error.response?.mapObject(BaseModel.self);
                    if let respoData = error.response?.data {
                        json = JSON(data: respoData);
                    }
                }
                catch {

                }

                if model == nil {
                    let base = self.globalErrorHandler(error: error);
                    model = base;
                }

                delegate(json, model, error.response);

            }


        }

    }

    func places( delegate: @escaping ServiceResponse) -> Void {

        APIProvider.request(ClientAPI.places()) { moyaResponse in

            var json: JSON? = nil;
            var model: Mappable? = nil;

            switch moyaResponse {
            case let .success(response):

                do {

                    let data = moyaResponse.value?.data
                    json = JSON(data: data!);
                    model = try response.mapObject(PlacesResponse.self)


                } catch {

                    debugPrint("Failed to parse register places to Model")
                }

                delegate(json, model, response)

                break

            case let .failure(error):

                debugPrint("URL: \(error.response?.request?.url?.description ?? "places>>")   Response : \(String(describing: error.response?.data.toJSON()?.description))", error, error.localizedDescription);

                do {
                    model = try error.response?.mapObject(BaseModel.self);
                    if let respoData = error.response?.data {
                        json = JSON(data: respoData);
                    }
                }
                catch {

                }

                if model == nil {
                    let base = self.globalErrorHandler(error: error);
                    model = base;
                }

                delegate(json, model, error.response);

            }


        }

    }

    func rent(rentModel: RentModel, delegate: @escaping ServiceResponse) -> Void {

        APIProvider.request(ClientAPI.rent(rentModel: rentModel)) { moyaResponse in

            var json: JSON? = nil;
            var model: Mappable? = nil;

            switch moyaResponse {
            case let .success(response):

                do {

                    let data = moyaResponse.value?.data
                    json = JSON(data: data!);
                    model = try response.mapObject(BaseModel.self)


                } catch {

                    debugPrint("Failed to parse rent Response to Model")
                }

                delegate(json, model, response)

                break

            case let .failure(error):

                debugPrint("URL: \(error.response?.request?.url?.description ?? "rent>>")   Response : \(String(describing: error.response?.data.toJSON()?.description))", error, error.localizedDescription);

                do {
                    model = try error.response?.mapObject(BaseModel.self);
                    if let respoData = error.response?.data {
                        json = JSON(data: respoData);
                    }
                }
                catch {

                }

                if model == nil {
                    let base = self.globalErrorHandler(error: error);
                    model = base;
                }

                delegate(json, model, error.response);

            }


        }

    }



    func globalErrorHandler(error:MoyaError) -> BaseModel {
        
        
        
        if (error as NSError).code == 4 {
            
         return  BaseModel(code: "4", message: "failed to Connect to Server")
        }
        assert(false, "\((error as NSError).localizedDescription)")
        return BaseModel(code: "\((error as NSError).code)", message: "Error Ocure \((error as NSError).code) , \n Contact Support for Help  ");
    }


}
