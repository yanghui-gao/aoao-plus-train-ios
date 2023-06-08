//
//  TriainingViewController.swift
//  aoao-mine-ios
//
//  Created by 高炀辉 on 2021/4/20.
//

import UIKit
import aoao_common_ios

class TrainingViewController: AAViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "年度训练试题"
		self.view.backgroundColor = UIColor(named: "bgcolor_F5F5F5_000000", in: AATrainModule.share.bundle, compatibleWith: nil)
    }

	@IBAction func open(_ sender: UIButton) {
		"https://ks.wjx.top/vm/ODYSIYD.aspx?title=骑士月度训练考试".openURL()
	}
}
