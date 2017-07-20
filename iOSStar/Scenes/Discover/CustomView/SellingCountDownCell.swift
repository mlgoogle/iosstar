//
//  SellingCountDownCell.swift
//  iOSStar
//
//  Created by J-bb on 17/7/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit



class SellingCountDownCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var backColorView: GradualColorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backColorView.bringSubview(toFront: countDownLabel)

        backColorView.realWidth = kScreenWidth
        backColorView.completeColors = [UIColor(hexString: "FE9023"), UIColor(hexString: "FBD831")]
        backColorView.isShowImage = false
        backColorView.percent = 1.0
        backColorView.addGradualColorLayer(isRound: false)

    }
    func setRemainingTime(count:Int) {
        if count < 0 || count == 0{
        
            infoLabel.text = "-----"
            countDownLabel.text = "-----"
        } else {
             infoLabel.text = "距离结束还有"
             countDownLabel.text = YD_CountDownHelper.shared.getTextWithTimeCount(timeCount: count)
        }
        infoLabel.setNeedsDisplay()
        countDownLabel.setNeedsDisplay()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
