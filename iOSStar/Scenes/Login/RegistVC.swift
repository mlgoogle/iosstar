//
//  RegistVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class RegistVC: UIViewController {
    
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
    
    @IBOutlet var passTf: UITextField!
    //验证码
    private var codeTime = 60
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func initUI(){
        
        let h  = UIScreen.main.bounds.size.height <= 568 ? 70.0 : 110
        self.top.constant = UIScreen.main.bounds.size.height/568.0 * CGFloat.init(h)
        print(self.top.constant)
        self.left.constant = UIScreen.main.bounds.size.width/320.0 * 30
        self.right.constant = UIScreen.main.bounds.size.width/320.0 * 30
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title =  "注册"
        initUI()
        // Do any additional setup after loading the view.
    }
    //MARK:-   发送验证码
    @IBAction func sendVaildCode(_ sender: Any) {
        
        if checkTextFieldEmpty([phoneTf]) && isTelNumber(num: phoneTf.text!) {
            vaildCodeBtn.isEnabled = false
            AppAPIHelper.login().SendCode(phone: phoneTf.text!, complete: { [weak self](result) -> ()? in
                
                if let response = result  {
                    
                    if response["result"] as! Int == 1 {
                        self?.timer = Timer.scheduledTimer(timeInterval: 1, target:
                            self!, selector: #selector(self?.updatecodeBtnTitle), userInfo: nil, repeats: true)
                        
                        self?.timeStamp = String.init(format: "%ld", response["timeStamp"] as!  Int)
                        self?.vToken = String.init(format: "%@", response["vToken"] as! String)
                        
                    }
                }
                return()
                //                print(result)
                
                }, error: { (error) -> ()? in
                    self.vaildCodeBtn.isEnabled = true
                    return()
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
        // Dispose of any resources that can be recreated.
    }
      //MARK:-   注册
    @IBAction func doregist(_ sender: Any) {
        
        if !checkTextFieldEmpty([phoneTf,passTf,codeTf]) {
            return
        }
        if !isTelNumber(num: phoneTf.text!){
            return
        }
        if ShareDataModel.share().isweichaLogin == true{
            
            AppAPIHelper.login().BindWeichat(phone: phoneTf.text!, timeStamp: 123, vToken: "1233", pwd: passTf.text!, openid:  ShareDataModel.share().wechatUserInfo[SocketConst.Key.openid]!, nickname:  ShareDataModel.share().wechatUserInfo[SocketConst.Key.nickname]!, headerUrl:  ShareDataModel.share().wechatUserInfo[SocketConst.Key.headimgurl]!, memberId: 123, agentId: "123", recommend: "123", deviceId: "1123", vCode: "123", complete: { [weak self](result) -> ()? in
                
                self?.doYunxin()
                
                return()
            }) { (error ) -> ()? in
                print(error)
            }
        }
        else{
            
            let string = "yd1742653sd" + self.timeStamp + self.codeTf.text! + self.phoneTf.text!
            
            if string.md5_string() != self.vToken{
                
                return
            }
            AppAPIHelper.login().regist(phone: phoneTf.text!, password: passTf.text!, complete: { [weak self](result) -> ()? in
                
                if let response = result {
                    if response["result"] as! Int == 1 {
                        self?.LoginYunxin()
                    }
                }
                return()
                
            }) { (error) -> ()? in
                return()
            }
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
            .phoneTf.text!, complete: { (result) -> ()? in
            
                let datadic = result as? Dictionary<String,String>
                
                if let _ = datadic {
                    //                let token = UserDefaults.standard.object(forKey: "tokenvalue") as! String
                    //                let phone = UserDefaults.standard.object(forKey: "phone") as! String
                    
                    NIMSDK.shared().loginManager.login(self.phoneTf.text!, token: self.passTf.text!, completion: { (error) in
                        if (error != nil){
                            self.dismissController()
                        }
                    })
                    UserDefaults.standard.set(self.phoneTf.text, forKey: "phone")
                    UserDefaults.standard.set((datadic?["token_value"])!, forKey: "tokenvalue")
                    UserDefaults.standard.synchronize()
                    
                    
                }
                return()
        }) { (error) -> ()? in
               return()
        }
//        let param: [String: Any] = [SocketConst.Key.name_value:  self.phoneTf.text!,
//                                    SocketConst.Key.accid_value:  self
//                                        .phoneTf.text!,]
//        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .registWY, dict: param as [String : AnyObject])
//        
//         BaseSocketAPI.shared().startRequest(packet, complete: { (result) -> ()? in
//            
//           
//            
//            return ()
//        }) { (error) -> ()? in
//            
//            return
//        }
//        
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
