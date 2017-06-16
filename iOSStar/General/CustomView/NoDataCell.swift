//
//  NoDataCell.swift
//  iOSStar
//
//  Created by J-bb on 17/6/6.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class NoDataCell: UITableViewCell {
   lazy var infoImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var infoLabel:UILabel = {
       
        let label = UILabel()
    
        label.textColor = UIColor(hexString: "333333")
        label.font = UIFont.systemFont(ofSize: 14)
        return label
        
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubViews()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
    }

    
    func addSubViews() {
        selectionStyle = .none
        contentView.addSubview(infoImageView)
        contentView.addSubview(infoLabel)
        contentView.backgroundColor = UIColor(hexString: "fafafa")
        infoImageView.snp.makeConstraints({ (make) in
            make.top.equalTo(100)
            make.centerX.equalTo(self)
        })
        
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(infoImageView.snp.bottom).offset(35)
            make.centerX.equalTo(infoImageView)
        }
        
    }
    
    func setImageAndTitle(image:UIImage?,title:String?) {
        if title == nil {
            remakeConstranints()
        }
        infoImageView.image = image
        infoLabel.text = title
    }
    func remakeConstranints() {
        infoImageView.snp.remakeConstraints { (make) in
            make.top.equalTo(30)
            make.width.equalTo(kScreenWidth)
            make.right.equalTo(0)
            make.left.equalTo(0)
        }
        infoLabel.removeFromSuperview()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
