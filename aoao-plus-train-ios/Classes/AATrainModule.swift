//
//  AATrainModule.swift
//  aoao-mine-ios
//
//  Created by 高炀辉 on 2021/3/9.
//

import UIKit

let modulerName = "aoao-train-ios"

public class AATrainModule {
	public static let share = AATrainModule()
	
	let storyboardName = "Train"
	
	public var mineStoryboard: UIStoryboard{
		return UIStoryboard(name: storyboardName, bundle: AATrainModule.share.bundle)
	}
	
	var bundle:Bundle?{
		get{
			guard let bundleURL = Bundle(for: AATrainModule.self).url(forResource: modulerName, withExtension: "bundle") else {
				return nil
			}
			guard let bundle = Bundle(url: bundleURL) else {
				return nil
			}
			return bundle
		}
	}
}
