//
//  SellingPriceCell.swift
//  iOSStar
//
//  Created by J-bb on 17/7/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SellingPriceCell: SellingBaseCell {

    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func setPanicModel(model: PanicBuyInfoModel?) {
        guard model != nil else {
            return
        }
        
        priceLabel.text = "￥\(String(format: "%.2f", model!.publish_price))/秒"
    }
}
