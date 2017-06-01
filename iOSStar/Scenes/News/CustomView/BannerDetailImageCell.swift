//
//  NewsDetailImageCell.swift
//  iOSStar
//
//  Created by J-bb on 17/6/1.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class BannerDetailImageCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setImage(imageUrl:String?) {
        guard imageUrl != nil else {
            return
        }
        
        iconImageView.kf.setImage(with: URL(string: imageUrl!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
