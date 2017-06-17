//
//  ExchangeViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/20.
//  Copyright © 2017年 sum. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController ,UITabBarControllerDelegate,NIMSystemNotificationManagerDelegate,NIMConversationManagerDelegate{

    // lazy
    lazy var tradingAlertView : TradingAlertView = {
        
        let alertView = Bundle.main.loadNibNamed("TradingAlertView", owner: nil, options: nil)?.first as! TradingAlertView
        
        return alertView
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "分答"
        // 测试弹窗
        // self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加", style: .done, target: self, action: #selector(rightItemClicks))
    
        
        // tradingAlertView.str = "撮合成功提醒：范冰冰（808080）转让成功，请到系统消息中查看，点击查看。"
        
        
//        if tradingAlertView.isShow == true {
//            UIApplication.shared.setStatusBarHidden(true, with: .fade)
//        } else {
//            UIApplication.shared.setStatusBarHidden(false, with: .fade)
//        }
//        tradingAlertView.showAlertView()
//        
//        tradingAlertView.messageAction = {
//            print("收到了吗")
//            
//        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    func rightItemClicks() {
    
            tradingAlertView.str = "撮合成功提醒：范冰冰（808080）转让成功，请到系统消息中查看，点击查看。"
            tradingAlertView.showAlertView()
            tradingAlertView.messageAction = {
            print("收到了吗")

            }

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

    


