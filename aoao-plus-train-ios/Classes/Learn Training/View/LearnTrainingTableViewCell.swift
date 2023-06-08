//
//  LearnTrainingTableViewCell.swift
//  aoao-mine-ios
//
//  Created by 高炀辉 on 2021/4/20.
//

import UIKit
import Kingfisher

class LearnTrainingTableViewCell: UITableViewCell {

	/// 图片
	@IBOutlet weak var headerImageView: UIImageView!
	
	/// 副标题
	@IBOutlet weak var subtitleLabel: UILabel!
	
	/// 标题
	@IBOutlet weak var titleLabel: UILabel!
	
	/// 是否通过
	@IBOutlet weak var isPassLabel: UILabel!
	
	/// 指示图
	@IBOutlet weak var rightIcon: UIImageView!
	
	var model: LearnTrainingModel? {
		didSet {
			guard let model = self.model else { return }
			subtitleLabel.text = model.summary
			titleLabel.text = model.title
			if let urlstr = model.iconUrl, let url = URL(string: urlstr)  {
				self.headerImageView.kf.setImage(with: url)
			}
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
