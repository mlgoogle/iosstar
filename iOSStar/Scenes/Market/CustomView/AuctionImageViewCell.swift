//
//  AuctionImageViewCell.swift
//  iOSStar
//
//  Created by J-bb on 17/6/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class AuctionImageViewCell: UITableViewCell {
    @IBOutlet weak var showImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setImageUrl(url:String) {
        showImageView.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "nodata_banner"), options: nil, progressBlock: nil, completionHandler: nil)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
