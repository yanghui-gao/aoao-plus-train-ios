//
//  TriainingViewController.swift
//  aoao-mine-ios
//
//  Created by 高炀辉 on 2021/4/20.
//

import UIKit
import aoao_plus_common_ios

class TrainingViewController: AAViewController {
	
	

	@IBOutlet weak var titleLabel: UILabel!
	
	@IBOutlet weak var explainLabel: UILabel!
	
	var url: String?
	
	var model:LearnTrainingModel?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.title = model?.title
		self.titleLabel.text = model?.title
		self.explainLabel.text = model?.summary
		self.view.backgroundColor = UIColor(named: "bgcolor_F5F5F5_000000", in: AATrainModule.share.bundle, compatibleWith: nil)
    }

	@IBAction func open(_ sender: UIButton) {
		guard let url = self.url else {
			self.view.aoaoMakeToast("获取URL失败, 请重试")
			return
		}
		url.openURL()
	}
}
