//
//  MarketDetailCommentHeaderView.swift
//  iOSStar
//
//  Created by J-bb on 17/5/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketDetailCommentHeaderView: UITableViewHeaderFooterView {

    var infoLabel:UILabel = {
       
        let label = UILabel()
        label.setAttributeText(text: "评价 999+", firstFont: 14, secondFont: 14, firstColor: UIColor(hexString: "070707"), secondColor: UIColor(hexString: "FB9938"), range: NSRange(location: 3, length: 4))
        return label
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    func addSubViews() {
        backgroundColor = UIColor(hexString: "fafafa")
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.left.equalTo(12)
            make.height.equalTo(14)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
    }


}
