//
//  DealStarInfoCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DealStarInfoCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setupData(model:MarketListModel?) {
        guard  model != nil else {
            return
        }
        iconImageView.kf.setImage(with: URL(string: model!.pic))
        nameLabel.text = model?.name


    }
    
    func setCount(count:Int) {
        positionLabel.text = "当前总持有\(count)秒"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
