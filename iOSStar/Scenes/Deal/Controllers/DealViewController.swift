//
//  DealViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DealViewController: UIViewController {

    
    var menuView:YD_VMenuView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 28)
        layout.itemSize = CGSize(width: 30, height: 15)
        layout.minimumInteritemSpacing = (kScreenWidth - 44 - 28 - 30 * 5) / 4
        menuView = YD_VMenuView(frame: CGRect(x: 44, y: 0, width: kScreenWidth, height: 64), layout: layout)
        menuView?.backgroundColor = UIColor.clear
        menuView?.isScreenWidth = true
        menuView?.reloadData()
        menuView?.items = ["求购","转让","已购","订单","明细"]
        navigationItem.titleView = menuView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
