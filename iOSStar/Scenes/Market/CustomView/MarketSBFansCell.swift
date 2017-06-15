//
//  MarketSBFansCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/18.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketSBFansCell: UITableViewCell {

    @IBOutlet var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        price.textColor = UIColor.init(hexString: AppConst.Color.orange)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
