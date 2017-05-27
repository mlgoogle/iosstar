//
//  DealSelectDateCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

protocol SelectDateDelegate {
    func startSelect(isStart:Bool)
}
class DealSelectDateCell: UITableViewCell {
    var delegate:SelectDateDelegate?

    @IBOutlet weak var endDateLabel: UILabel!

    @IBOutlet weak var startDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }


    @IBAction func startDateAction(_ sender: Any) {

        delegate?.startSelect(isStart: true)
    }
    @IBAction func endDateAction(_ sender: Any) {
        delegate?.startSelect(isStart: false)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
//可能会有问题
        
    }
}
