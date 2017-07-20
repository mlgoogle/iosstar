//
//  JoinVC.swift
//  iOSStar
//
//  Created by mu on 2017/6/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

import SVProgressHUD

class JoinVC: UIViewController, UITextViewDelegate ,UIGestureRecognizerDelegate{
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
  
    @IBOutlet weak var littleFieldText: UITextField!
    @IBOutlet weak var joinScrollView: UIScrollView!
    @IBOutlet weak var joinView: UIView!
    @IBOutlet weak var joinBgView: UIView!
    @IBOutlet weak var bgHeight: NSLayoutConstraint!
    //定义block来判断选择哪个试图
    var resultBlock: CompleteBlock?

    override func viewDidLoad() {
        super.viewDidLoad()
        bgHeight.constant = 150 + UIScreen.main.bounds.size.height
    }

    @IBAction func joinXingXiang(_ sender: UIButton) {
        if ShareDataModel.share().isweichaLogin == true && ShareDataModel.share().wechatUserInfo[SocketConst.Key.openid] != "" {
            wxJoin()
        }
        else {
            join()
        }
    }
    //注册
    func join() {
//        ShareDataModel.share().registerModel.memberId = toalFieldText.text!
//        ShareDataModel.share().registerModel.agentId = middleFieldText.text!
//        ShareDataModel.share().registerModel.recommend = littleFieldText.text!
        ShareDataModel.share().registerModel.channel = littleFieldText.text!
        AppAPIHelper.login().regist(model: ShareDataModel.share().registerModel, complete: { [weak self](result)  in
            if let response = result {
                if response["result"] as! Int == 1 {
                    SVProgressHUD.showSuccessMessage(SuccessMessage: "注册成功", ForDuration: 2.0, completion: {
                        self?.resultBlock!(doStateClick.doLogin as AnyObject)
                    })
                }
            }
        }) { (error) in
            self.didRequestError(error)
        }
//        ShareDataModel.share().registerModel.sub_agentId = littleFieldText.text!
//        if checkTextFieldEmpty([littleFieldText]){
//           
//              
////                SVProgressHUD.showErrorMessage(ErrorMessage: error.userInfo["NSLocalizedDescription"] as! String, ForDuration: 2.0, completion: nil)
//           
//        }
    }
    //微信绑定
    func wxJoin() {
//        ShareDataModel.share().wxregisterModel.memberId = toalFieldText.text!
//        ShareDataModel.share().wxregisterModel.agentId = middleFieldText.text!
        ShareDataModel.share().wxregisterModel.channel = littleFieldText.text!
//        ShareDataModel.share().wxregisterModel.recommend = littleFieldText.text!
//        ShareDataModel.share().wxregisterModel.sub_agentId = toalFieldText.text!
        AppAPIHelper.login().BindWeichat(model: ShareDataModel.share().wxregisterModel, complete: { (result)  in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.loginSuccessNotice), object: nil, userInfo: nil)
            
        }) { (error )  in
            
            SVProgressHUD.showErrorMessage(ErrorMessage:  error.userInfo["NSLocalizedDescription"] as! String, ForDuration: 2.0, completion: nil)
        }
    }
    

    //关闭
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        let win  : UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let tabar  : BaseTabBarController = win.rootViewController as! BaseTabBarController
        if tabar.selectedIndex == 1{
 
        }else{
            tabar.selectedIndex = 0
        }
        self.dismissController()
    }
    
    
}
