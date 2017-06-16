//
//  PositionStarCell.swift
//  iOSStar
//
//  Created by J-bb on 17/6/16.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class PositionStarCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setStar(model:StarInfoModel) {
        
        nameLabel.text = model.starname
        codeLabel.text = model.starcode
        countLabel.text = "\(model.ownseconds)"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
