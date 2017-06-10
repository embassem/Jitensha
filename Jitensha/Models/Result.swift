//
//	Result.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Result : NSObject, NSCoding, Mappable{

	var id : String?
	var location : Location?
	var name : String?


	class func newInstance(map: Map) -> Mappable?{
		return Result()
	}
	required init?(map: Map){}
	
    override init() {
        
        self.id = "0"
        self.name = "--"
        
    }
	func mapping(map: Map)
	{
		id <- map["id"]
		location <- map["location"]
		name <- map["name"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? String
         location = aDecoder.decodeObject(forKey: "location") as? Location
         name = aDecoder.decodeObject(forKey: "name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}

	}

}
