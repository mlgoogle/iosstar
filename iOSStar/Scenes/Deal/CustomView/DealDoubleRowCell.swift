//
//  DealDoubleRowCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DealDoubleRowCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var underNameLabel: UILabel!
    
    @IBOutlet weak var secondLabel1: UILabel!
    
    @IBOutlet weak var secondLabel2: UILabel!
    
    @IBOutlet weak var thirdLabel1: UILabel!
    
    @IBOutlet weak var thirdLabel2: UILabel!
    
    @IBOutlet weak var lastLabel1: UILabel!
    
    @IBOutlet weak var lastLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setColor(color:UIColor) {
        nameLabel.textColor = color
        underNameLabel.textColor = color
        secondLabel1.textColor = color
        secondLabel2.textColor = color
        thirdLabel1.textColor = color
        thirdLabel2.textColor = color
        lastLabel1.textColor = color
        lastLabel2.textColor = color        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
