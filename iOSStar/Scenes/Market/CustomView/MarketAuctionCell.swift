//
//  MarketAuctionCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketAuctionCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var price_label: UILabel!
    override func awakeFromNib() {
        price_label.textColor = UIColor.init(hexString: AppConst.Color.orange)
        super.awakeFromNib()
        
    }
    func setFans(model:FansListModel) {
        dateLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(model.trades!.positionTime), format: "MM-dd HH:mm:SS")
        
        iconImageView.kf.setImage(with: URL(string: model.user!.headUrl),placeholder:UIImage.init(named: "\(arc4random()%8+1)"))
        nameLabel.text = model.user!.nickname
        price_label.text = "\(model.trades!.openPrice)元/秒"
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
