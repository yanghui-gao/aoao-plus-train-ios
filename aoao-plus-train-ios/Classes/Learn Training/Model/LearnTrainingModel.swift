//
//	LearnTrainingModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON
import aoao_plus_net_ios


class LearnTrainingModel : NSObject, NSCoding, AAModelProtocol{

	var id : String!
	// 链接
	var link : String!
	// 概要
	var summary : String!
	// 标题
	var title : String!
	// 业务类型【10：学习资料，20：在线考试】
	var trainingType : Int!
	var learnTrainingType: LearnTrainingType {
		return LearnTrainingType.init(rawValue: trainingType) ?? .none
	}
	// 图标信息
	var iconUrl: String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	required init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		id = json["_id"].stringValue
		iconUrl = json["icon_info"]["url"].stringValue
		link = json["link"].stringValue
		summary = json["summary"].stringValue
		title = json["title"].stringValue
		trainingType = json["training_type"].intValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["_id"] = id
		}
		
		if link != nil{
			dictionary["link"] = link
		}
		if summary != nil{
			dictionary["summary"] = summary
		}
		if title != nil{
			dictionary["title"] = title
		}
		if trainingType != nil{
			dictionary["training_type"] = trainingType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         link = aDecoder.decodeObject(forKey: "link") as? String
         summary = aDecoder.decodeObject(forKey: "summary") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String
         trainingType = aDecoder.decodeObject(forKey: "training_type") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if link != nil{
			aCoder.encode(link, forKey: "link")
		}
		if summary != nil{
			aCoder.encode(summary, forKey: "summary")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if trainingType != nil{
			aCoder.encode(trainingType, forKey: "training_type")
		}

	}

}
