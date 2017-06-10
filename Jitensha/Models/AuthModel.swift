//
//	AuthModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class AuthModel : NSObject, NSCoding, Mappable{

	var email : String?
	var password : String?

    init(email: String?, password: String?) {
        self.email = email
        self.password = password
    }


	class func newInstance(map: Map) -> Mappable?{
		return AuthModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		email <- map["email"]
		password <- map["password"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         email = aDecoder.decodeObject(forKey: "email") as? String
         password = aDecoder.decodeObject(forKey: "password") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if password != nil{
			aCoder.encode(password, forKey: "password")
		}

	}

}
