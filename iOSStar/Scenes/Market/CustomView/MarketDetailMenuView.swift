//
//  MarketDetailMenuView.swift
//  iOSStar
//
//  Created by J-bb on 17/5/16.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketDetailMenuView: UITableViewHeaderFooterView {
    
    lazy var menuView:YD_VMenuView = {
        let menuView = YD_VMenuView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50), layout: nil)
        menuView.isScreenWidth = true
        menuView.items = ["简介","粉丝热度榜","拍卖","评论"]
        menuView.reloadData()
        return menuView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(menuView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
