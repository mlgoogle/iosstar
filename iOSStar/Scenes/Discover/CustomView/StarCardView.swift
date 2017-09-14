//
//  StarCardView.swift
//  iOSStar
//
//  Created by J-bb on 17/7/6.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import Kingfisher

class StarCardView: UICollectionViewCell {

    
    lazy var showImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true   

        
        imageView.image = UIImage(named: "blank")
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

    var backImage:UIImage?
    
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
//        showImageView.addSubview(infoView)
//        infoView.addSubview(statusLabel)
//        infoView.addSubview(priceLabel)
        showImageView.snp.makeConstraints { (make) in
            make.top.equalTo(53)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-60)
        }
//        infoView.snp.makeConstraints { (make) in
//            make.bottom.equalTo(0)
//            make.left.equalTo(0)
//            make.right.equalTo(0)
//            make.height.equalTo(75)
//        }
//
//        statusLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(14)
//            make.centerX.equalTo(infoView)
//            make.height.equalTo(14)
//        }
//        priceLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(statusLabel.snp.bottom).offset(14)
//            make.centerX.equalTo(statusLabel)
//            make.height.equalTo(18)
//        }
//        
        backImage = showImageView.image
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
        
    }
    
    func setStarModel(starModel:StarSortListModel) {

        guard URL(string:ShareDataModel.share().qiniuHeader + starModel.home_pic_tail) != nil else {
            return
        }
        
        showImageView.kf.setImage(with: URL(string:ShareDataModel.share().qiniuHeader + starModel.home_pic_tail)!, placeholder: UIImage(named: "blank"), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            if image != nil {
                self.backImage = image
            }
            
        }

        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
