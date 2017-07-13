//
//  SellingTimeAndCountCell.swift
//  iOSStar
//
//  Created by J-bb on 17/7/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SellingTimeAndCountCell: SellingBaseCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func setPanicModel(model: PanicBuyInfoModel?) {
        guard model != nil else {
            return
        }
        timeLabel.text = "发售时间：\(Date.yt_convertDateStrWithTimestempWithSecond(Int(model!.publish_begin_time), format: "yyyy.MM.dd"))-\(Date.yt_convertDateStrWithTimestempWithSecond(Int(model!.publish_end_time), format: "yyyy.MM.dd"))"
        countLabel.text = "发售总量：\(model!.publish_time)"
    }

}
