//
//	PlacesResponse.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class PlacesResponse : NSObject, NSCoding, Mappable{

	var results : [Result]?


	class func newInstance(map: Map) -> Mappable?{
		return PlacesResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		results <- map["results"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         results = aDecoder.decodeObject(forKey: "results") as? [Result]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if results != nil{
			aCoder.encode(results, forKey: "results")
		}

	}

}
