//
//  PubInfoHeaderView.swift
//  iOSStar
//
//  Created by J-bb on 17/5/10.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class PubInfoHeaderView: UITableViewHeaderFooterView {

    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: AppConst.Color.main)
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "个人简介"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hexString: "333333")
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(lineView)
        addSubview(titleLabel)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.width.equalTo(3)
            make.height.equalTo(17)
            make.centerY.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(7)
            make.centerY.equalTo(lineView)
            make.height.equalTo(15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
