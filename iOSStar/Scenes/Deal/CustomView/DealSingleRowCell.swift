//
//  DealSingleRowCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DealSingleRowCell: UITableViewCell {
    var dealType:[Int:String] = [-1:"委托转让",1:"委托求购"]
    var dealStatus:[Int:String] = [-2:"委托失败",0:"委托进行中", 1:"委托成功", 2:"委托成功"]
    @IBOutlet weak var nameLabel: UILabel!  
    
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var lastLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func setData(model:EntrustListModel) {
        
        StartModel.getStartName(startCode: model.symbol) { (response) in
            
            if let star = response as? StartModel {
                self.nameLabel.text = star.name
            } else {
                self.nameLabel.text = ""
            }
        }
        codeLabel.text = model.symbol
        secondLabel.text = "\(model.amount)/\(model.rtAmount)"
        thirdLabel.text = String(format: "%.2f", model.openPrice)
        if model.handle == 0 {
            lastLabel.text = dealType[model.buySell]
        } else {
            lastLabel.text = dealStatus[model.buySell]
        }
        lastLabel.textColor = UIColor(hexString: "666666")
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
