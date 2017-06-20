//
//  AuctionPositionInfoCell.swift
//  iOSStar
//
//  Created by J-bb on 17/6/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class AuctionPositionInfoCell: UITableViewCell {
    @IBOutlet weak var starCodeLabel: UILabel!

    @IBOutlet weak var positionCountLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 3
        backView.backgroundColor = UIColor.init(hexString: AppConst.Color.orange)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setPositionCountModel(model:PositionCountModel?, starCode:String?, starName:String?) {
        
        
        if model != nil {
            positionCountLabel.text = "\(model!.star_time)秒"
        }
        if  starCode != nil && starName != nil {
            starCodeLabel.text = "已持有\(starName!)(\(starCode!))"
        }
    }
}
