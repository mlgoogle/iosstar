//
//  ContactListCell.swift
//  iOSStar
//
//  Created by J-bb on 17/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class ContactListCell: UITableViewCell {

    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        chatButton.layer.borderWidth = 1
        chatButton.layer.borderColor = UIColor(hexString: "185ca5").cgColor
        chatButton.layer.cornerRadius = 2
        chatButton.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
