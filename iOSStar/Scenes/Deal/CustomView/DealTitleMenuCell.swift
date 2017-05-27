//
//  DealTitleMenuCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DealTitleMenuCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setTitles(titles:[String]) {
        
        for (index, title) in titles.enumerated() {
            let label = viewWithTag(3000 + index) as? UILabel
            label?.text = title
            
        }
    }

}
