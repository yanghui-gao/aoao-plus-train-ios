//
//  LearnTrainingViewModel.swift
//  aoao-plus-train-ios
//
//  Created by 高炀辉 on 2023/6/8.
//

import UIKit
import RxSwift
import aoao_plus_net_ios
import SwiftyJSON
import Moya
import aoao_plus_common_ios


class LearnTrainingViewModel: RefreshProtocol {
	/// 刷新序列
	var refreshStatusManage = PublishSubject<RefreshStatus>()
	/// 订单列表回调
	let outPutOrderListResultObservable = PublishSubject<(data: [LearnTrainingModel], isRrefresh: Bool)>()
	/// 额外参数
	let outPutOrderMetaResultObservable = PublishSubject<JSON>()
	/// 错误回调
	let outPutErrorObservable = PublishSubject<AAErrorModel>()
	
	let disposebag = DisposeBag()

	init(input: Input) {
		input.getLearnTrainingListObservable
			.map{LearnApi.getLearnTrainingList(type: $0.type, page: $0.page)}
			.map{MultiTarget($0)}
			.flatMapLatest{aoaoAPIProvider.rx.aoaoRequestToObservable($0)}
			.mapArrayAndMeta(dataType: LearnTrainingModel.self)
			.subscribe(onNext: { res in
				switch res {
				case .success(let result):
					let isrefresh = result.meta["page"].intValue == 1
					self.outPutOrderListResultObservable.onNext((data: result.data, isRrefresh: isrefresh))
					self.outPutOrderMetaResultObservable.onNext(result.meta)
				case .failure(let error):
					self.outPutErrorObservable.onNext(error)
				}
			}).disposed(by: disposebag)
	}
	
}
extension LearnTrainingViewModel {
	struct Input {
		/// 获取 学习资料考试列表
		let getLearnTrainingListObservable: Observable<(type: LearnTrainingType, page: Int)>
	}
}
