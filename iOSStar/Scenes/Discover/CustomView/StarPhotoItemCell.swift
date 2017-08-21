//
//  StarPhotoItemCell.swift
//  iOSStar
//
//  Created by J-bb on 17/7/7.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class StarPhotoItemCell: BaseItemCell {
    lazy var showImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "138415562044.jpg")
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
    }
    
    func addSubViews() {
        contentView.addSubview(showImageView)
        showImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    override func setData(data: AnyObject?, colorString: String?, isZoom: Bool) {
        if let urlString = data as? String {
            showImageView.kf.setImage(with: URL(string:qiniuHelper.shared().qiniuHeader +  urlString), placeholder: UIImage(named: "138415562044.jpg"), options: nil, progressBlock: nil, completionHandler: nil)
            
        }
    }

}
