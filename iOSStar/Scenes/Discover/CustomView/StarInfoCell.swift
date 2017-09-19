//
//  StarInfoCell.swift
//  iOSStar
//
//  Created by J-bb on 17/7/7.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class StarInfoCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var starNameLabel: UILabel!

    @IBOutlet weak var starIntroLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var backView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderColor = UIColor.white.cgColor
        iconImageView.layer.borderWidth = 1
        backView.clipsToBounds = true
    }


    func setBackImage(imageName:String) {
        backImageView.image = UIImage(named: imageName)
    }
    func setStarModel(starModel:StarSortListModel) {
        

        let url = URL(string:ShareDataModel.share().qiniuHeader + starModel.pic_tail)
        iconImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        starNameLabel.text = starModel.name
        starIntroLabel.text = starModel.work
    }
}
