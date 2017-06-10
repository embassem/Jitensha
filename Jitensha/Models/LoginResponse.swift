//
//	LoginResponse.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class LoginResponse : NSObject, NSCoding, Mappable{

	var accessToken : String?
	
	class func newInstance(map: Map) -> Mappable?{
		return LoginResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		accessToken <- map["accessToken"]
				
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if accessToken != nil{
			aCoder.encode(accessToken, forKey: "accessToken")
		}
				

	}

}
