//
//  MarketCommentCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/18.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketCommentCell: UITableViewCell {

    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!
    func setData(model:CommentModel) {
    
    
        commentLabel.text = model.comments
        
        nicknameLabel.text = model.nick_name
       
        iconImageView.kf.setImage(with: URL(string:ShareDataModel.share().qiniuHeader + model.head_url),placeholder:UIImage.init(named: "\(arc4random()%8+1)"))
        timeLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(model.cms_time), format: "YYYY-MM-dd")
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
