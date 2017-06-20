
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
    @IBOutlet weak var buyProgressView: GradualColorView!

    @IBOutlet weak var buyCountLabel: UILabel!
    @IBOutlet weak var sellCountLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var buyWidth: NSLayoutConstraint!
    @IBOutlet weak var sellProgressView: GradualColorView!
    override func awakeFromNib() {
        super.awakeFromNib()
    

        setDisPlay(percent: 0.5)
        let model = BuySellCountModel()
        model.buyCount = 0
        model.sellCount = 0
        setPercent(model: model, totalCount: 0)
    }
    func setDisPlay(percent:CGFloat) {
        countProgressView.percent = percent
        countProgressView.addGradualColorLayer(isRound:true)
        countProgressView.layer.cornerRadius = 8
        buyProgressView.isShowImage = false
        buyProgressView.percent = 1
        sellProgressView.isShowImage = false
        sellProgressView.percent = 1
        sellProgressView.completeColors = [UIColor(hexString: "4BE2C9"), UIColor(hexString: "BCE0DA")]
        buyProgressView.addGradualColorLayer(isRound:false)
        sellProgressView.addGradualColorLayer(isRound:false)
        
    }
    func setPercent(model:BuySellCountModel?,totalCount:Int) {

        var percent:CGFloat = 0.5
        var timePercent:CGFloat = 0.0
        if model != nil {
            buyCountLabel.text = "买入：\(model!.buyCount)人"
            sellCountLabel.text = "卖出：\(model!.sellCount)人"
            let all = CGFloat(model!.buyCount + model!.sellCount)
            if all != 0 {
                
                if model!.buyCount == 0 {
                    sellProgressView.setCornoerRadius(byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 8.0, height: 8.0))
                } else {
                    sellProgressView.setCornoerRadius(byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 8.0, height: 8.0))
                }
                if model!.sellCount == 0 {
                    buyProgressView.setCornoerRadius(byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 8.0, height: 8.0))
                } else{
                    buyProgressView.setCornoerRadius(byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 8.0, height: 8.0))
                }
                percent = CGFloat(model!.buyCount) / CGFloat(model!.buyCount + model!.sellCount)
                
                
            } else {
                setnormalCorner()
            }
            
            if model!.sellTime > totalCount {
                timePercent =  CGFloat(totalCount == 0 ? 1 : totalCount) / CGFloat(model!.sellTime)
            } else {
                timePercent = CGFloat(model!.sellTime) / CGFloat(totalCount == 0 ? 1 : totalCount)
            }
            totalCountLabel.text = "总计：\(totalCount)秒"

        } else {
            setnormalCorner()
        }
        buyWidth.constant = (kScreenWidth - 50) * percent
        buyProgressView.animation(percent: 1, width:buyWidth.constant)
        sellProgressView.animation(percent: 1,width:kScreenWidth - 50 - buyWidth.constant)
        countProgressView.animation(percent: timePercent,width:kScreenWidth - 50)
        

    }
    func setnormalCorner() {
        sellProgressView.setCornoerRadius(byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 8.0, height: 8.0))
        
        buyProgressView.setCornoerRadius(byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 8.0, height: 8.0))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
