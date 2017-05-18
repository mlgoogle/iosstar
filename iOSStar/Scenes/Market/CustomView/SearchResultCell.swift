//
//  SearchResultCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/10.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SearchResultCell: OEZTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func update(_ data: Any!) {
      
        let model = data as!  MarketClassifyModel
        
        titleLabel.text = model.name + "(" + String.init(format: "%d", model.code) + ")"
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
