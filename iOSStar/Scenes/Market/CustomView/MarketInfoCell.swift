//
//  MarketInfoCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/18.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketInfoCell: UITableViewCell {
    @IBOutlet weak var nationalityLabel: UILabel!

    @IBOutlet weak var colleageLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var constellationLabel: UILabel!
    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var nationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setData(model:BannerDetaiStarModel?) {
        nationalityLabel.text = model?.nationality
        workLabel.text = model?.work
        nationLabel.text = model?.nation
        birthLabel.text = model?.birth
        colleageLabel.text = model?.colleage
        constellationLabel.text = model?.constellaction
    }

}
