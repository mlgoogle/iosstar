//
//  RegistVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class RegistVC: UIViewController {
    
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
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title =  "注册"
        // Do any additional setup after loading the view.
    }
    @IBAction func sendVaildCode(_ sender: Any) {
        
        if checkTextFieldEmpty([phoneTf]) && isTelNumber(num: phoneTf.text!) {
             timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updatecodeBtnTitle), userInfo: nil, repeats: true)
        }
       
   
    }
    func updatecodeBtnTitle() {
        if codeTime == 0 {
            vaildCodeBtn.isEnabled = true
            vaildCodeBtn.setTitle("重新发送", for: .normal)
            codeTime = 60
            timer?.invalidate()
        vaildCodeBtn.backgroundColor = UIColor(hexString: AppConst.Color.main)
            return
        }
        vaildCodeBtn.isEnabled = false
        codeTime = codeTime - 1
        let title: String = "\(codeTime)秒后重新发送"
        vaildCodeBtn.setTitle(title, for: .normal)
        vaildCodeBtn.backgroundColor = UIColor(hexString: "ECECEC")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doregist(_ sender: Any) {
        
    
        AppAPIHelper.user().regist(phone: phoneTf.text!, password: passTf.text!, complete: { (result) -> ()? in
            
            return()
        }) { (error) -> ()? in
             return()
        }
        
        
    }
    @IBAction func doLogin(_ sender: Any) {
            self.resultBlock!(doStateClick.doLogin as AnyObject?)
    }
    
    
   
    @IBAction func weichatLogin(_ sender: Any) {
        let req = SendAuthReq.init()
        req.scope = AppConst.WechatKey.Scope
        req.state = AppConst.WechatKey.State
        WXApi.send(req)
    }
    @IBAction func doResetPass(_ sender: Any) {
        
           self.resultBlock!(doStateClick.doResetPwd as AnyObject)
    }

    @IBAction func sureClick(_ sender: Any) {
        
        
        self.dismissController()
        
//        if checkTextFieldEmpty([codeTf,phoneTf]){
//        
//              ShareDataModel.share().phone = codeTf.text!
//            ShareDataModel.share().codeToeken = phoneTf.text!
//            self.performSegue(withIdentifier: "pushInputPwd", sender: nil)
//        }
    }

}
