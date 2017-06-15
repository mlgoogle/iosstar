//
//  MarketAuctionCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketAuctionCell: UITableViewCell {

    @IBOutlet var price_label: UILabel!
    override func awakeFromNib() {
        price_label.textColor = UIColor.init(hexString: AppConst.Color.orange)
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
