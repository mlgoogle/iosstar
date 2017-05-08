//
//  LoginVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController {

    //定义block来判断选择哪个试图
     var resultBlock: CompleteBlock?
    //左边距
    @IBOutlet var left: NSLayoutConstraint!
   
    //右边距
    @IBOutlet var right: NSLayoutConstraint!
     //上边距
    @IBOutlet var top: NSLayoutConstraint!
    var tranform : Bool = true
    @IBOutlet weak var loginView: UIView!
    
    //手机号
    @IBOutlet weak var passPwd: UITextField!
    // 登录密码
    @IBOutlet weak var phone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        initUI()
      
          NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess(_:)), name: Notification.Name(rawValue:AppConst.WechatKey.ErrorCode), object: nil)

        
    }
    func initUI(){
    
//        self.top.constant = UIScreen.main.bounds.size.height/568.0 * 100
        self.left.constant = UIScreen.main.bounds.size.width/320.0 * 30
        self.right.constant = UIScreen.main.bounds.size.width/320.0 * 30
    }
    func loginSuccess(_ notice: NSNotification){
    
        
        AppAPIHelper.user().WeichatLogin(openid: ShareDataModel.share().wechatUserInfo[SocketConst.Key.openid]!, deviceId: "123", complete: { (result) -> ()? in
            
//             print(result)
            return()
        }) { (error) -> ()? in
             print(error)
            return()
            
        }
//        AppAPIHelper.user().BindWeichat(phone: "18643804362", timeStamp: 123, vToken: "1233", pwd: "124", openid:  ShareDataModel.share().wechatUserInfo[SocketConst.Key.openid]!, nickname:  ShareDataModel.share().wechatUserInfo[SocketConst.Key.nickname]!, headerUrl:  ShareDataModel.share().wechatUserInfo[SocketConst.Key.headimgurl]!, memberId: 123, agentId: "123", recommend: "123", deviceId: "1123", vCode: "123", complete: { (result) -> ()? in
//            
//            return()
//        }) { (error ) -> ()? in
//             print(error)
//           return()
//        }
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func initNav(){
    
        
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        btn.setBackgroundImage(UIImage.init(named: "close"), for: .normal)
        let navaitem = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = navaitem
        btn.addTarget(self, action: #selector(didClose), for: .touchUpInside)
    }
    func didClose(){
        
        let win  : UIWindow = ((UIApplication.shared.delegate?.window)!)!
        
        let tabar  : BaseTabBarController = win.rootViewController as! BaseTabBarController
        tabar.selectedIndex = 0
        self.dismissController()
    }
    @IBAction func doclick(_ sender: Any) {
        tranform = !tranform

        let req = SendAuthReq.init()
        req.scope = AppConst.WechatKey.Scope
        req.state = AppConst.WechatKey.State
        WXApi.send(req)

    }
    @IBAction func doRegist(_ sender: Any) {
        
        self.resultBlock!(doStateClick.doRegist as AnyObject?)

        
    }
      //登录
    @IBAction func doLogin(_ sender: Any) {
        
        
        if isTelNumber(num: phone.text!) && checkTextFieldEmpty([passPwd]){
            
            AppAPIHelper.user().login(phone: phone.text!, password: passPwd.text!, complete: { [weak self](result) -> ()? in
                
                
                let param: [String: Any] = [SocketConst.Key.name_value:  self!.phone.text!,
                                            SocketConst.Key.accid_value:  self!.phone.text!,]
                let packet: SocketDataPacket = SocketDataPacket.init(opcode: .registWY, dict: param as [String : AnyObject])
                
                BaseSocketAPI.shared().startRequest(packet, complete: { (result) -> ()? in
                    
                    SVProgressHUD.showErrorMessage(ErrorMessage: "登录成功", ForDuration: 0.5, completion: {
                        let datadic = result as? Dictionary<String,String>
                        
                        if let _ = datadic {
                            
                            UserDefaults.standard.set(self?.phone.text, forKey: "phone")
                            UserDefaults.standard.set((datadic?["token_value"])!, forKey: "tokenvalue")
                            UserDefaults.standard.synchronize()
                            self?.dismissController()
                            
                        }
                    })
                    
                    return ()
                }) { (error) -> ()? in
                    
                    return
                }
              
                return()
            }) { (error) -> ()? in
                print(error)
                return()
            }
        }
       

    }

    //忘记密码
    @IBAction func forGotPass(_ sender: Any) {
        
          ShareDataModel.share().isdoregist = false
        
        self.performSegue(withIdentifier: "pushToLogin", sender: nil)
    }
    //微信登录
    @IBAction func wechatLogin(_ sender: Any) {
        
        let req = SendAuthReq.init()
        req.scope = AppConst.WechatKey.Scope
        req.state = AppConst.WechatKey.State
        WXApi.send(req)
    }
    
    @IBAction func doResetPass(_ sender: Any) {
        
        self.resultBlock!(doStateClick.doResetPwd as AnyObject)
    }
//     //注册
//    @IBAction func doRegist(_ sender: Any) {
//        
//        ShareDataModel.share().isdoregist = true
//        
//        self.performSegue(withIdentifier: "pushToLogin", sender: nil)
//    }
    func loginwangyi(){
    
        SVProgressHUD.show(withStatus: "登录中")
        if checkTextFieldEmpty([phone]) {
            
            if isTelNumber(num: phone.text!)
            {
                
                
            }else{
                SVProgressHUD.showErrorMessage(ErrorMessage: "请输入正确的手机号", ForDuration: 0.5, completion: {
                    
                })
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        phone.resignFirstResponder
           view.endEditing(true)
        passPwd.resignFirstResponder
    }
}
