//
//  LearnTrainingXLViewController.swift
//  aoao-mine-ios
//
//  Created by 高炀辉 on 2021/4/20.
//

import UIKit
import RxSwift
import Tabman
import Pageboy
import aoao_plus_common_ios

class LearnTrainingXLViewController: TabmanViewController {
	
	private var viewControllers: [UIViewController] = []
	
	private var tmBarItemables: [TMBarItemable] = []
	
	let bar = TMBar.ButtonBar()
	
	var customCommentLeftBarButtonItem: UIBarButtonItem{
		get{
			let qhRightButton = UIBarButtonItem(image: UIImage(named: "popBack", in: AACommonMoudle.share.bundle, compatibleWith: nil), style: .done, target: self, action: #selector(popToBeforeViewController))
			qhRightButton.tintColor = UIColor(named: "navbackicon_06041D_8E8C96", in: AACommonMoudle.share.bundle, compatibleWith: nil)
			return qhRightButton
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUI()
	}
	func setUI() {
		self.navigationItem.leftBarButtonItem = self.customCommentLeftBarButtonItem
		self.title = "培训学习"
		self.view.backgroundColor = UIColor.init(named: "bgcolor_F5F5F5_000000", in: AATrainModule.share.bundle, compatibleWith: nil)
		setTMBar()
	}
	
	func setTMBar() {
		let tintColor = UIColor(named: "boss_000000-60_FFFFFF-60", in: AATrainModule.share.bundle, compatibleWith: nil) ?? .white
		let selectedTintColor = UIColor(named: "Color_00AD66", in: AATrainModule.share.bundle, compatibleWith: nil) ?? .white
		
		let stroyboard = AATrainModule.share.mineStoryboard
		let vc_1 = stroyboard.instantiateViewController(withIdentifier: "LearnTrainingViewController") as! LearnTrainingViewController
		vc_1.learnTrainingType = .learning
		vc_1.title = "学习"
		let vc_2 = stroyboard.instantiateViewController(withIdentifier: "LearnTrainingViewController") as! LearnTrainingViewController
		vc_2.learnTrainingType = .training
		vc_2.title = "在线考试"
		
		viewControllers = [vc_1, vc_2]
		tmBarItemables = [TMBarItem(title: "学习"), TMBarItem(title: "在线考试")]
		self.dataSource = self
		// 超过边界表现
		bar.indicator.overscrollBehavior = .compress
		// 横线权重
		bar.indicator.weight = .custom(value: 2)
		bar.indicator.backgroundColor = selectedTintColor
		// 自动根据内容铺满
		bar.layout.contentMode = .fit
		// 设置选中颜色 默认颜色
		bar.buttons.customize { (button) in
			button.font = UIFont.systemFont(ofSize: 14)
			button.tintColor = tintColor
			button.selectedTintColor = selectedTintColor
		}
		// 过渡动画配置
		bar.layout.transitionStyle = .snap // Customize
		// 添加至指定view
		addBar(bar, dataSource: self, at: .top)
		
	}
	
	@objc func popToBeforeViewController() {
		self.navigationController?.popViewController(animated: true)
	}
}
extension LearnTrainingXLViewController: PageboyViewControllerDataSource, TMBarDataSource {

	func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
		return viewControllers.count
	}

	func viewController(for pageboyViewController: PageboyViewController,
						at index: PageboyViewController.PageIndex) -> UIViewController? {
		return viewControllers[index]
	}

	func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
		return nil
	}

	func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
		let item = tmBarItemables[index]
		return item
	}
}
