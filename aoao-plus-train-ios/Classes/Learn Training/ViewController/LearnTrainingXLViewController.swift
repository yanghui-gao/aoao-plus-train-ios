//
//  LearnTrainingXLViewController.swift
//  aoao-mine-ios
//
//  Created by 高炀辉 on 2021/4/20.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import aoao_common_ios

class LearnTrainingXLViewController: ButtonBarPagerTabStripViewController {

	public var customCommentLeftBarButtonItem: UIBarButtonItem?{
		get{
			let qhRightButton = UIBarButtonItem(image: UIImage(named: "popBack", in: AACommonMoudle.share.bundle, compatibleWith: nil), style: .done, target: self, action: #selector(popToBeforeViewController))
			qhRightButton.tintColor = UIColor(named: "navbackicon_06041D_8E8C96", in: AACommonMoudle.share.bundle, compatibleWith: nil)
			return qhRightButton
		}
	}
	
	@IBOutlet weak var shopNameLabel: UILabel!
	
	override func viewDidLoad() {
		self.settings.style.buttonBarItemFont = .systemFont(ofSize: 16)
		self.settings.style.buttonBarItemTitleColor = UIColor.init(named: "color_2DCF90", in: AATrainModule.share.bundle, compatibleWith: nil)
		self.settings.style.selectedBarBackgroundColor = UIColor.init(named: "color_2DCF90", in: AATrainModule.share.bundle, compatibleWith: nil) ?? UIColor.white
		self.settings.style.buttonBarHeight = 40
		self.settings.style.buttonBarBackgroundColor = UIColor.init(named: "boss_FFFFFF_1A1A1A", in: AATrainModule.share.bundle, compatibleWith: nil)
		self.settings.style.buttonBarItemBackgroundColor = UIColor.init(named: "boss_FFFFFF_1A1A1A", in: AATrainModule.share.bundle, compatibleWith: nil)
		self.settings.style.selectedBarHeight = 2
		changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
			guard changeCurrentIndex == true else { return }
			oldCell?.label.textColor = UIColor.init(named: "boss_000000-60_FFFFFF-60", in: AATrainModule.share.bundle, compatibleWith: nil)
			newCell?.label.textColor = UIColor(named: "color_2DCF90", in: AATrainModule.share.bundle, compatibleWith: nil)
		}
		super.viewDidLoad()
		setUI()
	}
	func setUI() {
		self.navigationItem.leftBarButtonItem = self.customCommentLeftBarButtonItem
		self.title = "培训学习"
		self.view.backgroundColor = UIColor.init(named: "bgcolor_F5F5F5_000000", in: AATrainModule.share.bundle, compatibleWith: nil)
	}
	@objc func popToBeforeViewController(){
		self.navigationController?.popViewController(animated: true)
	}
	
	override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
		let stroyboard = AATrainModule.share.mineStoryboard
		let vc_1 = stroyboard.instantiateViewController(withIdentifier: "LearnTrainingViewController") as! LearnTrainingViewController
		vc_1.learnTrainingType = .learning
		vc_1.itemInfo.title = "学习"
		let vc_2 = stroyboard.instantiateViewController(withIdentifier: "LearnTrainingViewController") as! LearnTrainingViewController
		vc_2.learnTrainingType = .training
		vc_2.itemInfo.title = "在线考试"
		return [vc_1, vc_2]
	}
}

