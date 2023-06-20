//
//  LearnRouter.swift
//  aoao-mine-ios
//
//  Created by 高炀辉 on 2021/4/21.
//

import UIKit
import aoao_plus_common_ios

public struct LearnRouter {
	
	public static func initialize() {
		/// 培训学习
		navigator.register("learn".routerUrl) { url, values, context in
			let vc = LearnTrainingXLViewController()
			return vc
		}
		
		/// 在线考试
		navigator.register("training".routerUrl) { url, values, context in
			let vc = AATrainModule.share.mineStoryboard.instantiateViewController(withIdentifier: "TrainingViewController") as! TrainingViewController
			guard let para = context as? [String: Any?] else {
				return vc
			}
			if let model = para["model"] as? LearnTrainingModel {
				vc.model = model
			}
			if let url = para["url"] as? String {
				vc.url = url
			}
			return vc
		}
		
	}
}
