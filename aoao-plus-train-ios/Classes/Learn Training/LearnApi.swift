//
//  LearnApi.swift
//  aoao-plus-train-ios
//
//  Created by 高炀辉 on 2023/6/8.
//


import UIKit
import Moya
import aoao_plus_net_ios
import SwiftDate
import aoao_plus_common_ios

enum LearnApi {
	/// 获取学习列表
	case getLearnTrainingList(type: LearnTrainingType, page: Int)
}
extension LearnApi: TargetType, AuthenticationProtocol {
	var baseURL: URL {
		guard let url = URL(string: basicURL) else {
			fatalError("非法的URL字符串: \(basicURL)")
		}
		return url
	}
	var method: Moya.Method{
		return .post
	}
	public var task: Task {
		var params: [String: Any] = [:]
		switch self {
		case .getLearnTrainingList(let type, let page):
			params["_meta"] = ["page":page, "limit": 30]
			params["training_type"] = type.rawValue
		}
		return .requestParameters(parameters: params, encoding: JSONEncoding.default)
	}

	public var headers: [String: String]? {
		switch self {
		case .getLearnTrainingList(_, _):
			return ["X-CMD": "aoao.training.article.find"]
		}
	}
	var authenticationType: AuthenticationType?{
		return .xToken
	}
}
