//
//  DealOrderInfoCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DealOrderInfoCell: UITableViewCell {
    @IBOutlet weak var priceInfoLabel: UILabel!

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countInfoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func priceReduce(_ sender: Any) {
    }
   
    @IBAction func pricePlus(_ sender: Any) {
    }

    @IBAction func countPlus(_ sender: Any) {
    }
    @IBAction func countReduce(_ sender: Any) {
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
