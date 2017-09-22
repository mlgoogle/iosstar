//
//  LoginVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController ,UIGestureRecognizerDelegate,UITextFieldDelegate{

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    //定义block来判断选择哪个试图
     var resultBlock: CompleteBlock?
    //左边距
    @IBOutlet var left: NSLayoutConstraint!
    //右边距
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet var right: NSLayoutConstraint!
     //上边距
    @IBOutlet var top: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
   
    @IBOutlet var loginBtn: UIButton!
    var uid : Int = 0
    
    // 登录密码
    @IBOutlet weak var passPwd: UITextField!
    // 手机号
    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        initUI()
    
        passPwd.delegate = self
        passPwd.returnKeyType = .done
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func initUI(){
        
       loginBtn.titleLabel?.setAttributeText(text: "还没有账户 现在注册", firstFont: 14, secondFont: 14, firstColor: UIColor.init(hexString: "999999"), secondColor: UIColor.init(hexString: AppConst.Color.main), range: NSRange(location: 6, length: 4))
        
        let backViewTap = UITapGestureRecognizer.init(target: self, action: #selector(backViewTapClick))
        backView.addGestureRecognizer(backViewTap)
        backViewTap.delegate = self
    
        self.automaticallyAdjustsScrollViewInsets = false
        height.constant = 120 + UIScreen.main.bounds.size.height
        width.constant = UIScreen.main.bounds.size.width
        let h  = UIScreen.main.bounds.size.height <= 568 ? 60.0 : 80
        self.top.constant = UIScreen.main.bounds.size.height/568.0 * CGFloat.init(h)
        print(self.top.constant)
        self.left.constant = UIScreen.main.bounds.size.width/320.0 * 30
        self.right.constant = UIScreen.main.bounds.size.width/320.0 * 30
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: contentView))! {
            return false;
        }
        return true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
 
    func backViewTapClick() {
        
        didClose()
    }
    
    // MARK: - 导航栏
    func initNav(){
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        btn.setBackgroundImage(UIImage.init(named: "close"), for: .normal)
        let navaitem = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = navaitem
        btn.addTarget(self, action: #selector(didClose), for: .touchUpInside)
        if  (UserDefaults.standard.object(forKey: "lastLogin")) !=  nil {
          phone.text = UserDefaults.standard.object(forKey: "lastLogin") as? String
        }
    }
    //MARK:   界面消失
    func didClose(){
        
        let win  : UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let tabar  : BaseTabBarController = win.rootViewController as! BaseTabBarController

        if tabar.selectedIndex == 1 {
            
        } else {
            tabar.selectedIndex = 0
        }

      
      
        self.dismissController()
    }
    
    //MARK:   注册
    @IBAction func doRegist(_ sender: Any) {
        view.endEditing(true)
        self.phone.text = ""
        self.passPwd.text = ""
        ShareDataModel.share().isweichaLogin = false
        self.resultBlock!(doStateClick.doRegist as AnyObject?)
        
    }
    //MARK:-  登录
    @IBAction func doLogin(_ sender: Any) {

        if !checkTextFieldEmpty([phone]) {
            return
        }
        if !checkTextFieldEmpty([passPwd]) {
            return
        }
        if !isTelNumber(num: phone.text!) {
            SVProgressHUD.showErrorMessage(ErrorMessage: "手机号码格式错误", ForDuration: 2.0, completion: nil)
            return
        }
        if !isPassWord(pwd: passPwd.text!) {
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入6位字符以上密码", ForDuration: 2.0, completion: nil)
            return
        }
        SVProgressHUD.showProgressMessage(ProgressMessage: "登录中······")
        if isTelNumber(num: phone.text!) && checkTextFieldEmpty([passPwd]) {
            let loginRequestModel = LoginRequestModel()
            loginRequestModel.phone = phone.text!
            loginRequestModel.pwd = (passPwd.text?.md5_string())!
            AppAPIHelper.login().login(model: loginRequestModel, complete: {[weak self] (result) in
                SVProgressHUD.dismiss()

                let datadic = result as? StarUserModel
                  SVProgressHUD.showSuccessMessage(SuccessMessage: "登录成功", ForDuration: 2.0, completion: {

                    if let _ = datadic {
                        UserDefaults.standard.set(self?.phone.text, forKey: "phone")
                        UserDefaults.standard.set(self?.phone.text, forKey: "tokenvalue")
                        self?.uid = Int(datadic!.userinfo!.id)
                        UserDefaults.standard.synchronize()
                        self?.dismissController()
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.loginSuccess), object: nil, userInfo:nil)
                        StarUserModel.upateUserInfo(userObject: datadic!)
                        AppConfigHelper.shared().updateDeviceToken()

                    }
                })

            }, error: { (error) in
                self.didRequestError(error)
//                SVProgressHUD.showErrorMessage(ErrorMessage: "网络连接超时", ForDuration: 2.0, completion: nil)
            })
        }
    }
    @IBAction func law(_ sender: Any) {
        let vc = BaseWebVC()
        vc.loadRequest = "http://122.144.169.219:3389/law"
        vc.navtitle = "法律说明"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    //MARK:-   微信登录
    @IBAction func wechatLogin(_ sender: Any) {
        let req = SendAuthReq.init()
        req.scope = AppConst.WechatKey.Scope
        req.state = AppConst.WechatKey.State
        WXApi.send(req)
    }
    
    // MARK: - 关闭视图
    @IBAction func didMiss(_ sender: Any) {
        didClose()
    }
    //MARK:  重置密码
    @IBAction func doResetPass(_ sender: Any) {
        self.resultBlock!(doStateClick.doResetPwd as AnyObject)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
         view.endEditing(true)
    }
}
