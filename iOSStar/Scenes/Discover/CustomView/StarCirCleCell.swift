//
//  StarCirCleCell.swift
//  iOSStar
//
//  Created by sum on 2017/8/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
protocol StarCirCleCellDelegate {
    
    func starask()
    func voice()
    func staractive()
    
}
class StarCirCleCell: UITableViewCell {

    var delegate : StarCirCleCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    @IBAction func ask(sender: AnyObject) {
        delegate?.starask()
    }
   
    @IBAction func voice(sender: AnyObject) {
         delegate?.voice()
    }
    @IBAction func staractive(sender: AnyObject) {
         delegate?.staractive()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
