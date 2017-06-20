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
        label.textAlignment = NSTextAlignment.right
        label.text = "11111"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    lazy var changeLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(hexString: "CB4232")
        label.text = "0.22%"
        
        label.textColor = UIColor.white
        label.textAlignment = .center
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
        addSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubView()
    }
    func addSubView() {
        selectionStyle = .none
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(changeLabel)
        addSubview(codeLabel)
        contentView.backgroundColor = UIColor(hexString: "FAFAFA")
        
        
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
            make.height.equalTo(12)
            make.centerY.equalTo(changeLabel.snp.centerY)
            make.right.equalTo(changeLabel.snp.left).offset(-34)
        }
        changeLabel.layer.cornerRadius = 3
        changeLabel.layer.masksToBounds = true
        
    }
    
    func setupData(model:MarketListModel) {

        iconImageView.kf.setImage(with: URL(string: model.pic), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        nameLabel.text = model.name
        codeLabel.text = model.symbol
        priceLabel.text = String(format: "%.2f", model.currentPrice)
        var colorString = AppConst.Color.up
        if model.change < 0 {
            changeLabel.text = String(format: "%.2f%%", model.pchg * 100)
            colorString = AppConst.Color.down
        } else {
            changeLabel.text = String(format: "+%.2f%%", model.pchg * 100)
        }
        priceLabel.textColor = UIColor(hexString: colorString)
        changeLabel.backgroundColor = UIColor(hexString: colorString)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
