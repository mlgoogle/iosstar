//
//  MarketFansCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/18.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketFansCell: UITableViewCell {

    @IBOutlet var price_lb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        price_lb.textColor = UIColor.init(hexString: AppConst.Color.orange)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
