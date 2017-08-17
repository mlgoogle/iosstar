//
//  StarIntroduceCell.swift
//  iOSStar
//
//  Created by J-bb on 17/7/7.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

protocol PopVCDelegate {
    
    func back()
    func chat()
    func share()
}

class StarIntroduceCell: UITableViewCell {
    @IBOutlet weak var jobLabel: UILabel!

    @IBOutlet var share: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    var delegate:PopVCDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        backImageView.contentMode = .scaleAspectFill
        backImageView.clipsToBounds = true

    }

    @IBAction func shareClick(_ sender: Any) {
        delegate?.share()
    }

    @IBAction func backActiom(_ sender: Any) {
        delegate?.back()
    }
    @IBAction func chatAction(_ sender: Any) {
        delegate?.chat()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(model:StarDetaiInfoModel) {
        nameLabel.text = model.star_name
        
        backImageView.kf.setImage(with: URL(string: model.back_pic), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        iconImageView.kf.setImage(with: URL(string: model.head_url), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        jobLabel.text = model.work
        
    }
}
