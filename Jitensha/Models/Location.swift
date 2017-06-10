//
//	Location.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Location : NSObject, NSCoding, Mappable{

	var lat : Double?
	var lng : Double?


	class func newInstance(map: Map) -> Mappable?{
		return Location()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		lat <- map["lat"]
		lng <- map["lng"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         lat = aDecoder.decodeObject(forKey: "lat") as? Double
         lng = aDecoder.decodeObject(forKey: "lng") as? Double

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if lat != nil{
			aCoder.encode(lat, forKey: "lat")
		}
		if lng != nil{
			aCoder.encode(lng, forKey: "lng")
		}

	}

}
