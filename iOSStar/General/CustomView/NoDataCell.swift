//
//  NoDataCell.swift
//  iOSStar
//
//  Created by J-bb on 17/6/6.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class NoDataCell: UITableViewCell {
    var infoImageView:UIImageView = {
       let imageView = UIImageView()
        
        return imageView
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
        contentView.addSubview(infoImageView)
        infoImageView.snp.makeConstraints({ (make) in
            make.center.equalTo(contentView)

        })
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
