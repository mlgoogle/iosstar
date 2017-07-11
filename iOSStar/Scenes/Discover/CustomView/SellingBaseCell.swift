//
//  SellingBaseCell.swift
//  iOSStar
//
//  Created by J-bb on 17/7/10.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SellingBaseCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setPanicModel(model:PanicBuyInfoModel?) {
        guard model != nil else {
            return
        }
        
    }
}
