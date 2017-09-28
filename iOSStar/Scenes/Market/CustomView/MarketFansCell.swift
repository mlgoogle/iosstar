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
    func setOrderFans(model:FansListModel,isBuy:Bool,index:Int) {
        let headerUrl = model.user?.headUrl ?? ""
        let name = model.user?.nickname ?? ""
        
        dateLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(model.trades!.positionTime), format: "MM-DD hh:mm:ss")
        iconImaageView.kf.setImage(with: URL(string: headerUrl),placeholder:UIImage.init(named: "\(index%8+1)") )
        
        nameLabel.text = name
        topLabel.text = String.init(format: "%.2d", index + 1)
        price_lb.text = String(format: "%.2f/秒", model.trades!.openPrice)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
