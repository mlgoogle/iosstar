//
//  MarketViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/20.
//  Copyright © 2017年 sum. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        label.text = "行情"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(hexString: "185CA5")
        navigationItem.titleView = label
        automaticallyAdjustsScrollViewInsets = false
        let menuView = MarketMenuView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight))
        menuView.items = ["自选","艺人","体育明星","网红","海外知名人士"]
        view.addSubview(menuView)
        let lineView = navigationController?.navigationBar.subviews.first?.subviews.first
        lineView?.isHidden = true
        let color = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(color.imageWithColor(), for: .default)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func searchAction() {
        
    }

}
