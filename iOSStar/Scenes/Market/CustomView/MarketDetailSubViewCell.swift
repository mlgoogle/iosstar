//
//  MarketDetailSubViewCell.swift
//  iOSStar
// 
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketDetailSubViewCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!

    @IBOutlet weak var width: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setSubViews(views:[UIView]) {
        
        for (index,subView) in views.enumerated() {
            
            subView.frame = CGRect(x: CGFloat(index) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight - 50 - 64 - 50)
            
            addSubview(subView)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
