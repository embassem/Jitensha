//
//	RentModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class RentModel : NSObject, NSCoding, Mappable{

	var code : String?
	var expiration : String?
	var name : String?
	var number : String?

    init(code: String?, expiration: String?, name: String?, number: String?) {
        self.code = code
        self.expiration = expiration
        self.name = name
        self.number = number
    }


	class func newInstance(map: Map) -> Mappable?{
		return RentModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		code <- map["code"]
		expiration <- map["expiration"]
		name <- map["name"]
		number <- map["number"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? String
         expiration = aDecoder.decodeObject(forKey: "expiration") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         number = aDecoder.decodeObject(forKey: "number") as? String

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
		if expiration != nil{
			aCoder.encode(expiration, forKey: "expiration")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if number != nil{
			aCoder.encode(number, forKey: "number")
		}

	}

}




