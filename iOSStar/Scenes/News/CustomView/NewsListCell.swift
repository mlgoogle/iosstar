//
//  NewsListCell.swift
//  iOSStar
//
//  Created by J-bb on 17/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import Kingfisher
class NewsListCell: UITableViewCell {
    @IBOutlet weak var newsImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setData(data:NewsModel) {
        titleLabel.text = data.subject_name
        guard data.showpic_url.length() > 10 else {
            return
        }

        newsImageView.kf.setImage(with: URL(string:ShareDataModel.share().qiniuHeader + data.showpic_url), placeholder: UIImage(named:"8"), options: nil, progressBlock: nil, completionHandler: nil)

        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
