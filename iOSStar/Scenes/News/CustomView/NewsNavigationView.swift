//
//  NewsNavigationView.swift
//  iOSStar
//
//  Created by J-bb on 17/4/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SnapKit
class NewsNavigationView: UIView {

    var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "8")
        return imageView
    }()
    
    var PMLabel:UILabel = {
        let label = UILabel()
        label.text = "P M"
        label.textColor = transferStringToColor("e1eeff")
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    var timeLabel:UILabel = {
       
        let label = UILabel()
        label.text = "16:20"
        label.textColor = transferStringToColor("e1eeff")

        label.font = UIFont.systemFont(ofSize: 10.0)
        return label
    }()
    
    var dateLabel:UILabel = {
       let label = UILabel()
        label.text = "2017/04/25"
        label.textColor = transferStringToColor("fafafa")

        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(PMLabel)
        addSubview(timeLabel)
        addSubview(dateLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(24)
        }
        PMLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.top.equalTo(imageView)
            make.width.equalTo(26)
            make.height.equalTo(10)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(PMLabel)
            make.top.equalTo(PMLabel.snp.bottom).offset(5)
            make.width.equalTo(30)
            make.height.equalTo(8)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
