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
        chatButton.isUserInteractionEnabled = false
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func haveAChat(_sender: UIButton) {
        didSelectRowAction(3, data: cellModel)
    }
    
    override func update(_ data: Any!) {
        
        guard data != nil else{return}
        let model = data as! StarInfoModel
        StartModel.getStartName(startCode: model.starcode) { (response) in
            if let star = response as? StartModel {
                self.iconImageView.kf.setImage(with: URL(string: star.pic_url))
            }
            
        }
        
        
        cellModel = model
        nameLabel.text = model.starname
        jobLabel.text = model.faccid
        if statusBtn != nil{
        // 0 已拒绝 1 约见
        
         // statusBtn.isHidden = model.appoint == 0  ? true : false
            if model.appoint == 0 {
//                statusBtn.setTitle("已拒绝", for: .normal)
                statusBtn.isHidden = true
            } else if model.appoint == 1{
                statusBtn.setTitle("已约见", for: .normal)
            } else {
                statusBtn.setTitle("已拒绝", for: .normal)
            }
            statusBtn.backgroundColor = UIColor.init(hexString: AppConst.Color.orange)
        
        }
       
        
    }

}
