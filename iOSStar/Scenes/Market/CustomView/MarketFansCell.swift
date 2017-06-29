//
//  MarketFansCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/18.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketFansCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImaageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet var price_lb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        price_lb.textColor = UIColor.init(hexString: AppConst.Color.orange)
        // Initialization code
    }
    func setOrderFans(model:OrderFansListModel,isBuy:Bool,index:Int) {
        var headerUrl = ""
        var name = ""
        if isBuy {
            headerUrl = (model.buy_user!.headUrl)
            name = model.buy_user!.nickname
        } else {
            headerUrl = model.sell_user!.headUrl
            name = model.sell_user!.nickname
        }
        dateLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(model.trades!.openTime, format: "MM-dd HH:mm:ss")
        iconImaageView.kf.setImage(with: URL(string: headerUrl),placeholder:UIImage.init(named: "\(index%8+1)") )
        
        nameLabel.text = name
        topLabel.text = String.init(format: "%.2d", index + 1)
        price_lb.text = String(format: "%.2f元/秒", model.trades!.openPrice)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
