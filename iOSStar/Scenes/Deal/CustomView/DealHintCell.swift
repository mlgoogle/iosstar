//
//  DealHintCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

protocol ShowEntrustDelegate {
    func show()
}
class DealHintCell: UITableViewCell {

    var delegate:ShowEntrustDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func showEntrust(_ sender: Any) {
        
        delegate?.show()
    }
}
