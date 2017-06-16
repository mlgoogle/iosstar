//
//  DealDoubleRowCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DealDoubleRowCell: UITableViewCell {
    

    var dealType:[Int:String] = [-1:"转让",1:"求购"]
    var dealStatus:[Int32:String] = [0:"进行中", 1:"匹配中", 2:"挂单完成"]
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var underNameLabel: UILabel!
    
    @IBOutlet weak var secondLabel1: UILabel!
    
    @IBOutlet weak var secondLabel2: UILabel!
    
    @IBOutlet weak var thirdLabel1: UILabel!
    
    @IBOutlet weak var thirdLabel2: UILabel!
    
    @IBOutlet weak var lastLabel1: UILabel!
    
    @IBOutlet weak var lastLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setEntruset(model:EntrustListModel) {
        
        underNameLabel.text = model.symbol
        secondLabel1.text = String(format: "%.2f", model.openPrice)
        secondLabel2.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(model.positionTime), format: "HH:MM:SS")
        thirdLabel1.text = "\(model.amount)"
        thirdLabel2.text = "\(model.amount)"
        lastLabel1.text = dealType[model.buySell]
        lastLabel2.text = dealStatus[model.handle]
    }
    
    func setOrderModel(model:OrderListModel) {
        underNameLabel.text = model.symbol
        secondLabel1.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(model.closeTime), format: "YYYY-MM-DD")
        secondLabel2.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(model.closeTime), format: "HH:MM:SS")
//        thirdLabel1.text = "\(model.price)"
        thirdLabel2.text = "\(model.amount)"
  //      lastLabel1.text = dealType[model.buySell]
        lastLabel2.text = dealStatus[model.handle]
    }
    
    func setColor(color:UIColor) {
        nameLabel.textColor = color
        underNameLabel.textColor = color
        secondLabel1.textColor = color
        secondLabel2.textColor = color
        thirdLabel1.textColor = color
        thirdLabel2.textColor = color
        lastLabel1.textColor = color
        lastLabel2.textColor = color        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
