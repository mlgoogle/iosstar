//
//  SubViewItemCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/3.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SubViewItemCell: UITableViewCell {

    lazy var iconImageView:UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "8"))
        return imageView
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.text = "陈冠希"
        label.textColor = UIColor(hexString: "333333")
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    lazy var priceLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "cb4232")
        label.text = "11111"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    lazy var changeLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(hexString: "CB4232")
        label.text = "0.22%"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    lazy var codeLabel:UILabel = {
        let label = UILabel()
        label.text = "800001"
        label.textColor = UIColor(hexString: "999999")
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(changeLabel)
        addSubview(codeLabel)
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(40)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(13)
            make.top.equalTo(18)
            make.height.equalTo(14)
        }
        codeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.height.equalTo(9)
        }
        changeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.width.equalTo(70)
            make.height.equalTo(25)
            make.centerY.equalTo(iconImageView.snp.centerY)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(changeLabel.snp.left).inset(-34)
            make.width.equalTo(43)
            make.height.equalTo(12)
            make.centerY.equalTo(changeLabel.snp.centerY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(changeLabel)
        addSubview(codeLabel)
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(10)
            make.bottom.equalTo(10)
            make.width.equalTo(40)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(13)
            make.top.equalTo(18)
            make.height.equalTo(14)
        }
        codeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.height.equalTo(9)
        }
        changeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.width.equalTo(70)
            make.height.equalTo(25)
            make.centerY.equalTo(iconImageView.snp.centerY)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(changeLabel.snp.left).inset(34)
            make.width.equalTo(43)
            make.height.equalTo(12)
            make.centerY.equalTo(changeLabel.snp.centerY)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(changeLabel)
        addSubview(codeLabel)
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(10)
            make.bottom.equalTo(10)
            make.width.equalTo(40)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(13)
            make.top.equalTo(18)
            make.height.equalTo(14)
        }
        codeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.height.equalTo(9)
        }
        changeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.width.equalTo(70)
            make.height.equalTo(25)
            make.centerY.equalTo(iconImageView.snp.centerY)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(changeLabel.snp.left).inset(34)
            make.width.equalTo(43)
            make.height.equalTo(12)
            make.centerY.equalTo(changeLabel.snp.centerY)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
