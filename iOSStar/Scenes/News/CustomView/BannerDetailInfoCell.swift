//
//  NewsDetailInfoCell.swift
//  iOSStar
//
//  Created by J-bb on 17/6/1.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class BannerDetailInfoCell: UITableViewCell {
    @IBOutlet weak var nationalityLabel: UILabel!

    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var nationLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!

    @IBOutlet weak var collageLabel: UILabel!
    @IBOutlet weak var constellationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model:BannerDetaiStarModel?) {
        nationalityLabel.text = model?.nationality
        workLabel.text = model?.work
        nationLabel.text = model?.nation
        birthLabel.text = model?.birth
        collageLabel.text = model?.colleage
        
    }

}
