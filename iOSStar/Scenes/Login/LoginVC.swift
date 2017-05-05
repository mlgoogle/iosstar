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

    var tranform : Bool = true
    @IBOutlet weak var loginView: UIView!
    //手机号
    @IBOutlet weak var passPwd: UITextField!
    // 登录密码
    @IBOutlet weak var phone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        
      
          NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess(_:)), name: Notification.Name(rawValue:AppConst.WechatKey.ErrorCode), object: nil)

        
    }
    func loginSuccess(_ notice: NSNotification){
    
        
        AppAPIHelper.user().WeichatLogin(openid: ShareDataModel.share().wechatUserInfo[SocketConst.Key.openid]!, deviceId: "123", complete: { (result) -> ()? in
            
             print(result)
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
//        if !tranform {
//            self.regisView.isHidden = true
//             self.loginView.isHidden = false
//            UIView.animate(withDuration: 0.23) {
//                self.loginView.layer.transform.m34 = 0.0005
//                self.regisView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi/2), 0, 1, 0)
//                self.loginView.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0)
//                self.loginView.transform = self.loginView.transform.scaledBy(x: 0.5, y: 0.5);
//
//
//                
//            }
//        }else{
//            self.regisView.isHidden = false
//              self.loginView.isHidden = true
//              UIView.animate(withDuration: 0.23) {
//                  self.regisView.layer.transform.m34 = 0.0005
//                 self.regisView.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0)
//                  self.loginView.layer.transform = CATransform3DMakeRotation(-(CGFloat)(Double.pi/2), 0, 1, 0)
//                self.regisView.transform = self.loginView.transform.scaledBy(x: 1, y: 0.9);
//            }
//       }
    }
      //登录
    @IBAction func doLogin(_ sender: Any) {
        
        
        
        AppAPIHelper.user().login(phone: "18643803462", password: "123", complete: { (result) -> ()? in
            
            
            print(result)
            return()
        }) { (error) -> ()? in
            print(error)
            return()
        }
//         AppAPIHelper.user().regist(phone: "18643803462", password: "123", complete: { (resule) -> ()? in
//            
//            return()
//         }) { (error) -> ()? in
//            
//            return()
//        }

       

    }

    //忘记密码
    @IBAction func forGotPass(_ sender: Any) {
        
          ShareDataModel.share().isdoregist = false
        
        self.performSegue(withIdentifier: "pushToLogin", sender: nil)
    }
    //微信登录
    @IBAction func wechatLogin(_ sender: Any) {
    }
    
     //注册
    @IBAction func doRegist(_ sender: Any) {
        
        ShareDataModel.share().isdoregist = true
        
        self.performSegue(withIdentifier: "pushToLogin", sender: nil)
    }
    func loginwangyi(){
    
        SVProgressHUD.show(withStatus: "登录中")
        if checkTextFieldEmpty([phone]) {
            
            if isTelNumber(num: phone.text!)
            {
                let param: [String: Any] = [SocketConst.Key.name_value:  phone.text!,
                                            SocketConst.Key.accid_value:  phone.text!,]
                let packet: SocketDataPacket = SocketDataPacket.init(opcode: .registWY, dict: param as [String : AnyObject])
                
                BaseSocketAPI.shared().startRequest(packet, complete: { (result) -> ()? in
                    
                    SVProgressHUD.showErrorMessage(ErrorMessage: "登录成功", ForDuration: 0.5, completion: {
                        let datadic = result as? Dictionary<String,String>
                        print(datadic)
                        if let _ = datadic {
                            
                            UserDefaults.standard.set(self.phone.text, forKey: "phone")
                            UserDefaults.standard.set((datadic?["token_value"])!, forKey: "tokenvalue")
                            UserDefaults.standard.synchronize()
                            self.dismissController()
                            
                        }
                    })
                    
                    return ()
                }) { (error) -> ()? in
                    
                    return
                }
                
            }else{
                SVProgressHUD.showErrorMessage(ErrorMessage: "请输入正确的手机号", ForDuration: 0.5, completion: {
                    
                })
            }
        }
    }

}
