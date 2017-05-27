//
//  ExchangeViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/20.
//  Copyright © 2017年 sum. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "分答"
        
        rightItemClick()

        // 测试弹窗
        // navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "record_selected"), style: .done, target: self, action: #selector(rightItemClick(_ :)))
        
        
        // Do any additional setup after loading the view.
    }
    
    func rightItemClick()  {
        
        let alertVc = AlertViewController()
        alertVc.showAlertVc(imageName: "tangchuang_tongzhi",
                            titleLabelText: "允许通知",
                            subTitleText: "打开通知来获取最新\n明星回复消息以及交易信息~",
                            completeButtonTitle: "允 许") { (completeButton) in
                                print("跳转到下个界面的操作在这里")
        }
    }
}

    


