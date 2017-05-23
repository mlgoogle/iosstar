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
    
    lazy var titleLabel:UILabel = {
       
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "明星"
        label.textColor =  UIColor(hexString: "C2CFD8")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
    }
    func addSubViews() {
        backgroundColor = UIColor.clear
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    func setTitle(title:String?, colorString:String?) {
        
        titleLabel.text = title
        titleLabel.textColor = UIColor(hexString: colorString)
    }
}
