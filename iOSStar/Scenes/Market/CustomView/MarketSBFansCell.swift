//
//  MarketSBFansCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/18.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketSBFansCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        price.textColor = UIColor.init(hexString: AppConst.Color.orange)
        
    }

    
    func setOrderFans(model:FansListModel,isBuy:Bool) {
        let headerUrl = model.user?.headUrl ?? ""
        let name = model.user?.nickname ?? ""
   
        dateLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(model.trades!.positionTime), format: "MM-DD hh:mm:ss")

        iconImageView.kf.setImage(with: URL(string: headerUrl),placeholder:UIImage.init(named: "1"))
        nameLabel.text = name
        price.text = String(format: "%.2f/秒", model.trades!.openPrice)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
