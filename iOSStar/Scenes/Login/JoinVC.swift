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
    @IBOutlet weak var toalFieldText: UITextField!
    @IBOutlet weak var middleFieldText: UITextField!
    @IBOutlet weak var littleFieldText: UITextField!
    @IBOutlet weak var joinScrollView: UIScrollView!
    @IBOutlet weak var joinView: UIView!
    @IBOutlet weak var joinBgView: UIView!
    //定义block来判断选择哪个试图
    var resultBlock: CompleteBlock?

    override func viewDidLoad() {
        super.viewDidLoad()
//        joinBgView.isUserInteractionEnabled = false
        joinScrollView.contentSize = CGSize.init(width: kScreenWidth, height: kScreenHeight+200)
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
        ShareDataModel.share().registerModel.memberId = Int(toalFieldText.text!)!
        ShareDataModel.share().registerModel.agentId = middleFieldText.text!
        ShareDataModel.share().registerModel.recommend = littleFieldText.text!
        if checkTextFieldEmpty([toalFieldText,middleFieldText,littleFieldText]){
            AppAPIHelper.login().regist(model: ShareDataModel.share().registerModel, complete: { [weak self](result)  in
                if let response = result {
                    if response["result"] as! Int == 1 {
                        SVProgressHUD.showSuccessMessage(SuccessMessage: "注册成功", ForDuration: 2.0, completion: {
                            self?.resultBlock!(doStateClick.doLogin as AnyObject)
                        })
                    }
                }
            }) { (error) in
                SVProgressHUD.showErrorMessage(ErrorMessage: error.userInfo["NSLocalizedDescription"] as! String, ForDuration: 2.0, completion: nil)
            }
        }
    }
    //微信绑定
    func wxJoin() {
        ShareDataModel.share().wxregisterModel.memberId = Int(toalFieldText.text!)!
        ShareDataModel.share().wxregisterModel.agentId = middleFieldText.text!
        ShareDataModel.share().wxregisterModel.recommend = littleFieldText.text!
        AppAPIHelper.login().BindWeichat(model: ShareDataModel.share().wxregisterModel, complete: { [weak self](result)  in
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
    
    
    // 拦截中间contentView的点击事件
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: joinView))! {
            return false;
        }
        return true;
    }
}
