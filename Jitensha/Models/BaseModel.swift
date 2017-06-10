//
//	BaseModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class BaseModel : NSObject, NSCoding, Mappable{

	var code : String?
	var message : String?

    init(code: String?, message: String?) {
        self.code = code
        self.message = message
    }


	class func newInstance(map: Map) -> Mappable?{
		return BaseModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		code <- map["code"]
		message <- map["message"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? String
         message = aDecoder.decodeObject(forKey: "message") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}

	}

}
