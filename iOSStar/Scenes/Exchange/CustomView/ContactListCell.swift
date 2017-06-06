//
//  ContactListCell.swift
//  iOSStar
//
//  Created by J-bb on 17/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class ContactListCell: OEZTableViewCell {

    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    var cellModel: StarInfoModel = StarInfoModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        chatButton.layer.borderWidth = 1
        chatButton.layer.borderColor = UIColor(hexString: AppConst.Color.main).cgColor
        chatButton.layer.cornerRadius = 2
        chatButton.layer.masksToBounds = true
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func haveAChat(_sender: UIButton) {
        didSelectRowAction(3, data: cellModel)
    }
    
    override func update(_ data: Any!) {
        let model = data as! StarInfoModel
        cellModel = model
        nameLabel.text = model.starname
        jobLabel.text = model.faccid
        if statusBtn != nil{
        // 0 已拒绝 1 约见
         statusBtn.isHidden = model.appoint == 0  ? true : false
        }
       
        
    }

}
