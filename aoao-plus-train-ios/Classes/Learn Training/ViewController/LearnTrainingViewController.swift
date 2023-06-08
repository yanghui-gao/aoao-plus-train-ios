//
//  LearnTrainingViewController.swift
//  aoao-mine-ios
//
//  Created by 高炀辉 on 2021/4/20.
//

import UIKit
import aoao_plus_common_ios

enum LearnTrainingType {
	case learning	// 学习
	case training	// 培训(在线考试)
}

class LearnTrainingViewController: AAViewController {
	
	@IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var customTableView: UITableView!
	
	var learnTrainingType:LearnTrainingType = .learning
	
	var dateSource:[[String: String]] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setDateSource()
		self.setUI()
		
    }
	func setDateSource() {
		switch learnTrainingType {
		case .learning:
			dateSource = [["title":"MDS骑士培训月", "subtitle": "安全管理&专业技能", "image": "header_1", "type": "learning_1"],
						  ["title":"驻店外送员操作程序SOC", "subtitle": "工作标准", "image": "header_2", "type": "learning_2"],
						  ["title":"智能取餐柜骑手操作指引", "subtitle": "操作说明", "image": "header_3", "type": "learning_3"]]
		default:
			dateSource = [["title":"年度训练试题", "subtitle": "MDS外送员专用", "image": "header_6", "type": "training"]]
			
		}
		tableViewHeightConstraint.constant = CGFloat(dateSource.count * 84)
	}
	func setUI() {
		self.view.backgroundColor = UIColor.init(named: "bgcolor_F5F5F5_000000", in: AATrainModule.share.bundle, compatibleWith: nil)
		
		self.customTableView.layer.cornerRadius = 4
	}
}
extension LearnTrainingViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dateSource.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LearnTrainingTableViewCell
		cell.titleLabel.text = dateSource[indexPath.row]["title"]
		cell.subtitleLabel.text = dateSource[indexPath.row]["subtitle"]
		if let imageName = dateSource[indexPath.row]["image"] {
			cell.headerImageView.image = UIImage.init(named: imageName, in: AATrainModule.share.bundle, compatibleWith: nil)
		}
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let type = dateSource[indexPath.row]["type"] else {
			return
		}
		switch type {
		case "learning_1":
			"https://lite.aoaosong.com/study/?title=MDS骑士训练月训练资料".openURL()
		case "learning_2":
			// 跳转操作程序soc
			guard let path = Bundle.main.path(forResource: "SOC", ofType: "pdf") else{
				return
			}
			let pdfurl = NSURL(fileURLWithPath:path)
			"\(pdfurl)?title=驻店外送员操作程序".openURL()
		case "learning_3":
			/// 跳转操作指引
			guard let path = Bundle.main.path(forResource: "guidance", ofType: "pdf") else{
				return
			}
			let pdfurl = NSURL(fileURLWithPath:path)
			"\(pdfurl)?title=智能取餐柜操作指引".openURL()
		case "training":
			"training".openURL()
		default:
			print("other")
		}
	}
}
