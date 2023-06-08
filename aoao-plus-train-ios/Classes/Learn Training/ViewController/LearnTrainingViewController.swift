//
//  LearnTrainingViewController.swift
//  aoao-mine-ios
//
//  Created by 高炀辉 on 2021/4/20.
//

import UIKit
import RxSwift
import DZNEmptyDataSet
import aoao_plus_common_ios

enum LearnTrainingType: Int {
	case learning = 10	// 学习
	case training = 20	// 培训(在线考试)
	case none = -10086	// 未知
}

class LearnTrainingViewController: AAViewController {
	
	@IBOutlet weak var customTableView: UITableView!
	
	var learnTrainingType:LearnTrainingType = .learning
	
	var dateSource:[LearnTrainingModel] = []
	
	var listViewModel:LearnTrainingViewModel?
	
	let getListObservable = PublishSubject<(type: LearnTrainingType, page: Int)>()
	
	var page = 1
	
	let disposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUI()
		bindViewModel()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.getListObservable.onNext((type: self.learnTrainingType, page: 1))
	}
	func setUI() {
		self.view.backgroundColor = UIColor.init(named: "bgcolor_F5F5F5_000000", in: AATrainModule.share.bundle, compatibleWith: nil)
		
		self.customTableView.layer.cornerRadius = 4
		
		self.customTableView.emptyDataSetSource = self
		
		self.customTableView.emptyDataSetDelegate = self
		
		self.customTableView.tableFooterView = UIView()
	}
	func bindViewModel() {
		let orderInput = LearnTrainingViewModel.Input.init(getLearnTrainingListObservable: self.getListObservable)
		
		self.listViewModel = LearnTrainingViewModel.init(input: orderInput)
		
		self.listViewModel?
			.outPutOrderListResultObservable
			.subscribe(onNext: { res in
				if res.isRrefresh {
					self.dateSource = res.data
				} else {
					self.dateSource += res.data
				}
				
				self.customTableView.reloadData()
		}).disposed(by: disposeBag)
		
		self.listViewModel?
			.outPutOrderMetaResultObservable
			.subscribe(onNext: { [unowned self] meta in
				self.listViewModel?.refreshStatusManage.onNext(.endFooterRefresh)
				self.listViewModel?.refreshStatusManage.onNext(.endHeaderRefresh)
				// 处理是否还有更多数据
				let hasMore = meta["has_more"].boolValue
				// 请求成功 page 变化
				self.page = meta["page"].intValue
				self.listViewModel?.refreshStatusManage.onNext(.footerStatus(isHidden: false, isNoMoreData: !hasMore))
			}).disposed(by: disposeBag)
		
		self.listViewModel?.refreshBind(to: self.customTableView, headerHandle: {
			self.getListObservable.onNext((type: self.learnTrainingType, page: 1))
		}, footerHandle: {
			let page = self.page + 1
			self.getListObservable.onNext((type: self.learnTrainingType, page: page))
		}).disposed(by: self.disposeBag)
		
		self.listViewModel?
			.outPutErrorObservable
			.subscribe(onNext: { [unowned self] error in
				self.view.aoaoMakeToast(error.zhMessage)
				self.listViewModel?.refreshStatusManage.onNext(.endFooterRefresh)
				self.listViewModel?.refreshStatusManage.onNext(.endHeaderRefresh)
		}).disposed(by: disposeBag)
	}
}
extension LearnTrainingViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dateSource.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LearnTrainingTableViewCell
		cell.model = dateSource[indexPath.row]
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = dateSource[indexPath.row]
		var link = model.link ?? ""
		if link.contains("?") {
			link = link + "title=\(model.title ?? "")"
		} else {
			link = link + "?title=\(model.title ?? "")"
		}
		switch model.learnTrainingType {
		case .learning:
			link.openURL()
		case .training:
			"training".openURL(para: ["url": link])
		default:
			self.view.aoaoMakeToast("未知状态, 点击无效")
			return
		}
	}
}
extension LearnTrainingViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
	public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
		return UIImage(named: "none-data", in: AATrainModule.share.bundle, compatibleWith: nil)
	}
	public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
		let attributes = [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0),
			NSAttributedString.Key.foregroundColor: UIColor(named: "boss_000000-40_FFFFFF-40", in: AATrainModule.share.bundle, compatibleWith: nil) ?? .darkGray
		]
		return NSAttributedString(string: "暂无数据", attributes: attributes)
	}

	public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
		return true
	}
}
