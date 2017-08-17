//
//  MarketExperienceCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/18.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
protocol MarketExperienceCellDelegate {
    
    func showMore()
    func Packup()
    
}

class MarketExperienceCell: UITableViewCell {

    @IBOutlet var showHeight: NSLayoutConstraint!
    @IBOutlet var show: UIButton!
    var delegate:MarketExperienceCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    @IBAction func showMore(_ sender: Any) {
       let btn = sender as! UIButton
        if btn.titleLabel?.text  == "点击收起"{
          delegate?.Packup()
        }else{
          delegate?.showMore()
        }
      
    }

    func setTitle(title:String) {
        titleLabel.text = title
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
