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
      
        

        
    }
    func initUI(){
    
        let h  = UIScreen.main.bounds.size.height <= 568 ? 60.0 : 110
        self.top.constant = UIScreen.main.bounds.size.height/568.0 * CGFloat.init(h)
        print(self.top.constant)
        self.left.constant = UIScreen.main.bounds.size.width/320.0 * 30
        self.right.constant = UIScreen.main.bounds.size.width/320.0 * 30
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
     //MARK:   界面消失
    func didClose(){
        
        let win  : UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let tabar  : BaseTabBarController = win.rootViewController as! BaseTabBarController
        tabar.selectedIndex = 0
        self.dismissController()
    }

    //MARK:   注册
    @IBAction func doRegist(_ sender: Any) {
           view.endEditing(true)
        self.resultBlock!(doStateClick.doRegist as AnyObject?)

        
    }
      //登录
    @IBAction func doLogin(_ sender: Any) {
        
        
        if isTelNumber(num: phone.text!) && checkTextFieldEmpty([passPwd]){
            
            AppAPIHelper.login().login(phone: phone.text!, password: passPwd.text!, complete: { [weak self](result) -> ()? in
                
                
                let param: [String: Any] = [SocketConst.Key.name_value:  self!.phone.text!,
                                            SocketConst.Key.accid_value:  self!.phone.text!,]
                let packet: SocketDataPacket = SocketDataPacket.init(opcode: .registWY, dict: param as [String : AnyObject])
                
                BaseSocketAPI.shared().startRequest(packet, complete: { (result) -> ()? in
                    
                    SVProgressHUD.showErrorMessage(ErrorMessage: "登录成功", ForDuration: 0.5, completion: {
                        let datadic = result as? Dictionary<String,String>
                        
                        if let _ = datadic {
                            let token = UserDefaults.standard.object(forKey: "tokenvalue") as! String
                            let phone = UserDefaults.standard.object(forKey: "phone") as! String
                            
                            NIMSDK.shared().loginManager.login(phone, token: token, completion: { (error) in
                                if (error != nil){
                                    self?.dismissController()
                                }
                            })
                            UserDefaults.standard.set(self?.phone.text, forKey: "phone")
                            UserDefaults.standard.set((datadic?["token_value"])!, forKey: "tokenvalue")
                            UserDefaults.standard.synchronize()
                            
                            
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

    // //MARK:   忘记密码
    @IBAction func forGotPass(_ sender: Any) {
        
          ShareDataModel.share().isweichaLogin = false
        
        self.performSegue(withIdentifier: "pushToLogin", sender: nil)
    }
    // //MARK:   微信登录
    @IBAction func wechatLogin(_ sender: Any) {
        
        let req = SendAuthReq.init()
        req.scope = AppConst.WechatKey.Scope
        req.state = AppConst.WechatKey.State
        WXApi.send(req)
    }
    @IBAction func didMiss(_ sender: Any) {
        self.dismissController()
    }
     //MARK:  重置密码
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
   
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        phone.resignFirstResponder
           view.endEditing(true)
        passPwd.resignFirstResponder
    }
}
