//
//  AuctionHeaderCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class AuctionHeaderCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    //顶部展示star图片
    @IBOutlet var showImageView: UIImageView!
    //当前持有此明星时间数量
    @IBOutlet weak var positionCount: UILabel!
    //明星名称以及代码
    @IBOutlet weak var starCodeLabel: UILabel!
    
    //拍卖倒计时剩余时间
    @IBOutlet weak var timeLabel: UILabel!
    //转让委托总数据量占比
    @IBOutlet var sellProgressView: GradualColorView!
    @IBOutlet weak var countProgressView: GradualColorView!
    @IBOutlet var buyProgressView: GradualColorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        countProgressView.percent = 0.5
        countProgressView.addGradualColorLayer(isRound:true)
        countProgressView.layer.cornerRadius = 8
        buyProgressView.isShowImage = false
        buyProgressView.percent = 1
        sellProgressView.isShowImage = false
        sellProgressView.percent = 1
        buyProgressView.addGradualColorLayer(isRound:false)
        sellProgressView.addGradualColorLayer(isRound:false)
        sellProgressView.setCornoerRadius(byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 8.0, height: 8.0))
        buyProgressView.setCornoerRadius(byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 8.0, height: 8.0))
        backView.layer.cornerRadius = 3
    }
    func setTimeText(text:String) {
        
        if text == "拍卖未开始" {
            timeLabel.text = text
        } else {
            timeLabel.setAttributeText(text: "剩余拍卖时间: \(text)", firstFont: 16, secondFont: 16, firstColor: UIColor(hexString: "333333"), secondColor: UIColor(hexString: "FB9938"), range: NSRange(location: 8, length: text.length()))
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
