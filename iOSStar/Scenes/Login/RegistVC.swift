//
//  RegistVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class RegistVC: UIViewController {
    
    @IBOutlet weak var rbackView: UIView!
    @IBOutlet weak var rcontentView: UIView!
    
    @IBOutlet var left: NSLayoutConstraint!
    
    
    //时间戳
    var timeStamp =  ""
    //token
    var vToken = ""
    //右边距
    @IBOutlet var right: NSLayoutConstraint!
    //上边距
    @IBOutlet var top: NSLayoutConstraint!
    //定义block来判断选择哪个试图
    var resultBlock: CompleteBlock?
    @IBOutlet weak var codeTf: UITextField!
    
    @IBOutlet var phoneTf: UITextField!
    //定时器
    private var timer: Timer?
    //验证码
    @IBOutlet weak var vaildCodeBtn: UIButton!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet var passTf: UITextField!
    //验证码
    private var codeTime = 60
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func initUI(){
        
        let h  = UIScreen.main.bounds.size.height <= 568 ? 70.0 : 90
        self.top.constant = UIScreen.main.bounds.size.height/568.0 * CGFloat.init(h)
        print(self.top.constant)
        self.left.constant = UIScreen.main.bounds.size.width/320.0 * 30
        self.right.constant = UIScreen.main.bounds.size.width/320.0 * 30
        height.constant = 100 + UIScreen.main.bounds.size.height
        width.constant = UIScreen.main.bounds.size.width
//        let tap  = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
//        view.addGestureRecognizer(tap)
        let tap  = UITapGestureRecognizer.init(target: self, action: #selector(rtapClick))
        rcontentView.addGestureRecognizer(tap)
        
        let rbackViewTap = UITapGestureRecognizer.init(target: self, action: #selector(rbackViewTapClick))
        rbackView.addGestureRecognizer(rbackViewTap)
    }
    
    // 拦截中间contentView的点击事件
    func rtapClick(){
       
    }
    
    func rbackViewTapClick() {
        
        let win  : UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let tabar  : BaseTabBarController = win.rootViewController as! BaseTabBarController
        tabar.selectedIndex = 0
        self.dismissController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title =  "注册"
        initUI()
        // Do any additional setup after loading the view.
    }
    //17682310986
    //MARK:-   发送验证码
    @IBAction func sendVaildCode(_ sender: Any) {
        
        if checkTextFieldEmpty([phoneTf]) && isTelNumber(num: phoneTf.text!) {
            vaildCodeBtn.isEnabled = false
            SVProgressHUD.showProgressMessage(ProgressMessage: "")
            AppAPIHelper.login().SendCode(phone: phoneTf.text!, complete: { [weak self](result)  in
                SVProgressHUD.dismiss()
                self?.vaildCodeBtn.isEnabled = true
                if let response = result  {
                    
                    if response["result"] as! Int == 1 {
                        self?.timer = Timer.scheduledTimer(timeInterval: 1, target:
                            self!, selector: #selector(self?.updatecodeBtnTitle), userInfo: nil, repeats: true)
                        
                        self?.timeStamp = String.init(format: "%ld", response["timeStamp"] as!  Int)
                        self?.vToken = String.init(format: "%@", response["vToken"] as! String)
                        
                    }
                }
     
                }, error: { (error)  in
                    SVProgressHUD.showErrorMessage(ErrorMessage: "短信发送失败,请稍后再试", ForDuration: 2, completion: nil)
                    print("----\(error.description)")
                    self.vaildCodeBtn.isEnabled = true
            })
        }
    }
    //MARK:-   更新秒数
    func updatecodeBtnTitle() {
        if codeTime == 0 {
            vaildCodeBtn.isEnabled = true
            vaildCodeBtn.setTitle("重新发送", for: .normal)
            codeTime = 60
            timer?.invalidate()
            
            vaildCodeBtn.backgroundColor = UIColor(hexString: "BCE0DA")
            return
        }
        vaildCodeBtn.isEnabled = false
        codeTime = codeTime - 1
        let title: String = "\(codeTime)秒重新发送"
        vaildCodeBtn.setTitle(title, for: .normal)
        
        vaildCodeBtn.backgroundColor = UIColor(hexString: "ECECEC")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
      //MARK:-   注册
    @IBAction func doregist(_ sender: Any) {
        
        if !checkTextFieldEmpty([phoneTf,passTf,codeTf]) {
            return
        }
        if !isTelNumber(num: phoneTf.text!){
            return
        }
        if ShareDataModel.share().isweichaLogin == true && ShareDataModel.share().wechatUserInfo[SocketConst.Key.openid] != "" {
            bindWeChat()
        }
        else {
            login()
        }

    }
    //MARK:-  regist()
    func login() {
        let string = "yd1742653sd" + self.timeStamp + self.codeTf.text! + self.phoneTf.text!
        if string.md5_string() != self.vToken{
            return
        }
        AppAPIHelper.login().regist(phone: phoneTf.text!, password: (passTf.text?.md5_string())!, complete: { [weak self](result)  in
            if let response = result {
                if response["result"] as! Int == 1 {
                    SVProgressHUD.showSuccessMessage(SuccessMessage: "注册成功", ForDuration: 1.0, completion: {
                          self?.resultBlock!(doStateClick.doLogin as AnyObject)
                    })
                }
            }
        }) { (error) in
            // print("--------- \(error.userInfo["NSLocalizedDescription"] as! String)")
            SVProgressHUD.showErrorMessage(ErrorMessage: error.userInfo["NSLocalizedDescription"] as! String, ForDuration: 1.0, completion: nil)
        }
    }
    func bindWeChat() {
        let string = "yd1742653sd" + self.timeStamp + self.codeTf.text! + self.phoneTf.text!
        if string.md5_string() != self.vToken{
            return
        }
        AppAPIHelper.login().BindWeichat(phone: phoneTf.text!, timeStamp: 123, vToken: "1233", pwd: (passTf.text?.md5_string())!, openid:  ShareDataModel.share().wechatUserInfo[SocketConst.Key.openid]!, nickname:  ShareDataModel.share().wechatUserInfo[SocketConst.Key.nickname]!, headerUrl:  ShareDataModel.share().wechatUserInfo[SocketConst.Key.headimgurl]!, memberId: 123, agentId: "123", recommend: "123", deviceId: "1123", vCode: "123", complete: { [weak self](result)  in
            
            self?.LoginYunxin()

        }) { (error )  in
            print(error)
            SVProgressHUD.showErrorMessage(ErrorMessage:  error.userInfo["NSLocalizedDescription"] as! String, ForDuration: 0.5, completion: nil)
        }
    }
       //MARK:-   去登录
    @IBAction func doLogin(_ sender: Any) {
        view.endEditing(true)
        self.resultBlock!(doStateClick.doLogin as AnyObject?)
    }
    // MARK - 微信登录
    @IBAction func weichatLogin(_ sender: Any) {
        let req = SendAuthReq.init()
        req.scope = AppConst.WechatKey.Scope
        req.state = AppConst.WechatKey.State
        WXApi.send(req)
    }
         //MARK:-   忘记密码
    @IBAction func doResetPass(_ sender: Any) {
        self.resultBlock!(doStateClick.doResetPwd as AnyObject)
    }
    
    //MARK:- 网易云登录
    func LoginYunxin(){
        
        AppAPIHelper.login().registWYIM(phone: self.phoneTf.text!, token: self
            .phoneTf.text!, complete: { (result) in
                let datadic = result as? Dictionary<String,String>
                if let _ = datadic {
                    UserDefaults.standard.set(self.phoneTf.text, forKey: "phone")
                    UserDefaults.standard.set((datadic?["token_value"])!, forKey: "tokenvalue")
                    UserDefaults.standard.synchronize()
                    NIMSDK.shared().loginManager.login(self.phoneTf.text!, token: self.passTf.text!, completion: { (error) in
                        if (error != nil){
                            self.dismissController()
                        }
                    })
                }
        }) { (error)  in
        }
    }
    @IBAction func didMiss(_ sender: Any) {
        let win  : UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let tabar  : BaseTabBarController = win.rootViewController as! BaseTabBarController
        tabar.selectedIndex = 0
        self.dismissController()
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        
    }
    
}
