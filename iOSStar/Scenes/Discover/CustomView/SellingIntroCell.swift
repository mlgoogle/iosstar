//
//  SellingIntroCell.swift
//  iOSStar
//
//  Created by J-bb on 17/7/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SellingIntroCell: SellingBaseCell {

    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setPanicModel(model: PanicBuyInfoModel?) {
        guard model != nil else {
            return
        }
        nickNameLabel.text = model?.star_name
        iconImageView.kf.setImage(with: URL(string: model!.head_url), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
