//
//  MaketBannerCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/18.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SDCycleScrollView
class MaketBannerCell: UITableViewCell {

    @IBOutlet weak var banner: SDCycleScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let urlString = "http://pic27.nipic.com/20130320/3822951_105204803000_2.jpg"
        banner.imageURLStringsGroup = [urlString, urlString, urlString]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
