//
//  SelectPayTypeCell.swift
//  iOSStar
//
//  Created by sum on 2017/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SelectPayTypeCell: UITableViewCell {

    @IBOutlet weak var selectImg: UIImageView!
    @IBOutlet weak var payTypeImg: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        selectImg.image = UIImage.init(named: "timg.png")
        // Configure the view for the selected state
    }

    
}
