//
//  StarCardView.swift
//  iOSStar
//
//  Created by J-bb on 17/7/6.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class StarCardView: UICollectionViewCell {

    
   lazy var showImageView:UIImageView = {
       let imageView = UIImageView()
    
    imageView.image = UIImage(named: "138415562044.jpg")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true  
        return imageView
        
    }()
    lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "7C09AC")
        return view
    }()
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "正式出售"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "￥7.06/秒"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()

    
   override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubViews()
    }
    
    
    func addSubViews() {
    
        showImageView.layer.cornerRadius = 4
        showImageView.layer.masksToBounds = true
        showImageView.layer.shadowColor = UIColor.gray.cgColor
        showImageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        contentView.addSubview(showImageView)
        showImageView.addSubview(infoView)
        infoView.addSubview(statusLabel)
        infoView.addSubview(priceLabel)
        showImageView.snp.makeConstraints { (make) in
            make.top.equalTo(53)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-60)
        }
        infoView.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(75)
        }

        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(14)
            make.centerX.equalTo(infoView)
            make.height.equalTo(14)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(statusLabel.snp.bottom).offset(14)
            make.centerX.equalTo(statusLabel)
            make.height.equalTo(18)
        }
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
