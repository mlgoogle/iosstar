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
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
    }
    
    @IBAction func showMore(_ sender: UIButton) {
        if sender.titleLabel?.text  == "点击收起"{
          delegate?.Packup()
//          sender.setTitle("点击展开", for: .normal)
        }else{
          delegate?.showMore()
//          sender.setTitle("点击收起", for: .normal)
        }
    }

    func setTitle(title:String) {
        let att = NSMutableAttributedString.init(string: title)
        titleLabel.attributedText = att
        showMore(show)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
