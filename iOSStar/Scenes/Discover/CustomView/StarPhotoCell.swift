//
//  StarPhotoCell.swift
//  iOSStar
//
//  Created by J-bb on 17/7/7.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation

class StarPhotoCell: UITableViewCell {
    
    lazy var menuView: YD_VMenuView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 18

        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.itemSize = CGSize(width: 230, height: 140)
        let menuView = YD_VMenuView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 140), layout: layout)
        menuView.isShowLineView = false

        menuView.itemIdentifier = StarPhotoItemCell.className()
        menuView.itemClass = StarPhotoItemCell.classForCoder()
        menuView.menuCollectionView?.backgroundColor = UIColor(hexString: "fafafa")
        return menuView
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(menuView)

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView.addSubview(menuView)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(menuView)
    }
    
    func setImageUrls(images:[String]?, delegate:MenuViewDelegate?) {
        menuView.delegate = delegate
        menuView.itemData = images as [AnyObject]?
        menuView.reloadData()
    }
}
