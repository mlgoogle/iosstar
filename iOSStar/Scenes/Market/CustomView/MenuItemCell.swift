//
//  MenuItemCell.swift
//  iOSStar
//
//  Created by J-bb on 17/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SnapKit

class MenuItemCell: UICollectionViewCell {
    
    var titleLabel:UILabel = {
       
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "明星"
        label.textColor = transferStringToColor("C2CFD8")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    
    func setTitle(title:String) {
        
        titleLabel.text = title
    }
}
