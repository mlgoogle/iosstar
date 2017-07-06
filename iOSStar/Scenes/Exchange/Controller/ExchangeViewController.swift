//
//  ExchangeViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/20.
//  Copyright © 2017年 sum. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController ,UITabBarControllerDelegate,NIMSystemNotificationManagerDelegate,NIMConversationManagerDelegate{
    
    var needPwd :Int = 2
    var realName :Bool = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //为了添加判断来请求防止崩溃
        if checkLogin()
        {
            self.getUserInfo { [weak self ](result) in
                if let response = result{
                    let object = response as! UserInfoModel
                    self?.needPwd = object.is_setpwd
                    
                }
            }
            
            self.getUserRealmInfo { [weak self](result) in
                if let model = result{
                    if let object =  model as? [String : AnyObject]{
                        if object["realname"] as! String == ""{
                            self?.realName = true
                        }else{
                         self?.realName = false
                        }
                    }
                }
            }
        }
    }
    
    // 订单列表Action
    @IBAction func toOrderList(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Exchange", bundle: nil).instantiateViewController(withIdentifier: "SystemMessageVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // 明星通讯录Action
    @IBAction func toStarContacts(_ sender: UIButton) {
        
        if self.needPwd == 1 {
            let alertVc = AlertViewController()
            alertVc.showAlertVc(imageName: "tangchuang_tongzhi",
                                
                                titleLabelText: "开通支付",
                                subTitleText: "需要开通支付才能进行充值等后续操作。\n开通支付后，您可以求购明星时间，转让明星时间，\n和明星在‘星聊’中聊天，并且还能约见明星。",
                                completeButtonTitle: "我 知 道 了") {[weak alertVc] (completeButton) in
                                    alertVc?.dismissAlertVc()
                                    let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "TradePassWordVC")
                                    self.navigationController?.pushViewController(vc, animated: true )
                                    return
            }
        }else{
         
            if realName {
                   let alertVc = AlertViewController()
                alertVc.showAlertVc(imageName: "tangchuang_tongzhi",
                                    titleLabelText: "您还没有身份验证",
                                    subTitleText: "您需要进行身份验证,\n之后才可以进行明星时间交易",
                                    completeButtonTitle: "开 始 验 证") {[weak alertVc] (completeButton) in
                                        alertVc?.dismissAlertVc()
                                        
                                        let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "VaildNameVC")
                                        self.navigationController?.pushViewController(vc, animated: true )
                                        return
                }
            }
            else {
                let vc = UIStoryboard.init(name: "Exchange", bundle: nil).instantiateViewController(withIdentifier: "ContactListViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "星聊"
    }
    
}




