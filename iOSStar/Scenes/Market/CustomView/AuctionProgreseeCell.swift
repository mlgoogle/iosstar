
//
//  AuctionProgreseeCell.swift
//  iOSStar
//
//  Created by J-bb on 17/6/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class AuctionProgreseeCell: UITableViewCell {
    @IBOutlet weak var countProgressView: GradualColorView!
    @IBOutlet weak var percentProgressView: DoubleGradualView!

    @IBOutlet weak var buyCountLabel: UILabel!
    @IBOutlet weak var sellCountLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
        setDisPlay(percent: 0.5)

    }
    func setDisPlay(percent:CGFloat) {
        countProgressView.percent = percent
        countProgressView.addGradualColorLayer(isRound:true)
        countProgressView.layer.cornerRadius = 8
       
        percentProgressView.isShowImage = false
        percentProgressView.percent = 1
        percentProgressView.completeColors = [UIColor(red: 251 / 255.0, green: 153 / 255.0, blue: 56 / 255.0, alpha: 1.0), UIColor(red: 251 / 255.0, green: 106 / 255.0, blue: 56 / 255.0, alpha: 1.0), UIColor(hexString: "4BE2C9"),UIColor(hexString: "BCE0DA")]
        percentProgressView.animation(locations: [0.5,0.5])

        percentProgressView.addGradualColorLayer(isRound: true)
        

    }
    func setPercent(model:BuySellCountModel?,totalCount:Int) {

        var percent:CGFloat = 0.5
        var timePercent:CGFloat = 0.0
        if model != nil {
            buyCountLabel.text = "买入：\(model!.buyCount)人"
            sellCountLabel.text = "卖出：\(model!.sellCount)人"
            let all = CGFloat(model!.buyCount + model!.sellCount)
            if all != 0 {
                percent = CGFloat(model!.buyCount) / CGFloat(model!.buyCount + model!.sellCount)
            }
            
            if model!.sellTime > totalCount {
                timePercent =  CGFloat(totalCount == 0 ? 1 : totalCount) / CGFloat(model!.sellTime)
            } else {
                timePercent = CGFloat(model!.sellTime) / CGFloat(totalCount == 0 ? 1 : totalCount)
            }
            totalCountLabel.text = "总计：\(totalCount)秒"

        }
        
        percentProgressView.animation(locations: [0,NSNumber(value:Double(percent)),NSNumber(value:Double(percent)),1.0 ])
        countProgressView.animation(percent: timePercent,width:kScreenWidth - 50)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
