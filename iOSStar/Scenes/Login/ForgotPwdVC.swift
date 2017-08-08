//
//  FindPwdVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/21.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class ForgotPwdVC: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var doRset: UIButton!
    //时间戳
    var timeStamp =  ""
    //token
    var vToken = ""
    private var timer: Timer?
    //验证码
    private var codeTime = 60
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var vaildCodeBtn: UIButton!
    
    @IBOutlet weak var codeTf: UITextField!
    @IBOutlet weak var first_input: UITextField!
    
    @IBOutlet weak var second_input: UITextField!
    
    @IBAction func valuechange(_ sender: Any) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self) 
    }
    //MARK: 监听输入址变化
    func valueChange(_ textFiled : Notification){
        if phoneTf.text != "" && codeTf.text != "" && first_input.text != "" && second_input.text != "" {
            
            self.doRset.isEnabled = true
            self.doRset.backgroundColor = UIColor.init(hexString: AppConst.Color.main)
        }else{
            self.doRset.isEnabled = false
            self.doRset.backgroundColor = UIColor.init(hexString: "B8B8B8")
        }
    }
    //MARK: 界面消失删除通知
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "重置密码"
        //监听键盘弹起 来改变输入址
        if UserDefaults.standard.object(forKey: "phone") as? String != nil {
            phoneTf.text  = UserDefaults.standard.object(forKey: "phone") as? String
            phoneTf.isUserInteractionEnabled = false
        }
        NotificationCenter.default.addObserver(self , selector: #selector(valueChange(_:)), name:NSNotification.Name.UITextFieldTextDidChange, object: first_input)
        NotificationCenter.default.addObserver(self , selector: #selector(valueChange(_:)), name:NSNotification.Name.UITextFieldTextDidChange, object: phoneTf)
        NotificationCenter.default.addObserver(self , selector: #selector(valueChange(_:)), name:NSNotification.Name.UITextFieldTextDidChange, object: codeTf)
        NotificationCenter.default.addObserver(self , selector: #selector(valueChange(_:)), name:NSNotification.Name.UITextFieldTextDidChange, object: second_input)
        
    }
    //MARK: 显示密码
    @IBAction func doShowPass(_ sender: Any) {
        
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        if btn.tag == 100 {
            first_input.isSecureTextEntry = !first_input.isSecureTextEntry
        }
        if btn.tag == 101 {
            second_input.isSecureTextEntry = !second_input.isSecureTextEntry
        }
    }
    //MARK: 发送验证码
    @IBAction func sendVaildCode(_ sender: Any) {

        if checkTextFieldEmpty([phoneTf]) && isTelNumber(num: phoneTf.text!) {
            self.vaildCodeBtn.isEnabled = false
            let checkRegisterRequestModel = CheckRegisterRequestModel()
            checkRegisterRequestModel.phone = phoneTf.text!
            AppAPIHelper.login().CheckRegister(model: checkRegisterRequestModel, complete: {[weak self] (checkRegistResult) in
                if let checkRegistResponse = checkRegistResult {
                    if checkRegistResponse["result"] as! Int == 0 {
                        SVProgressHUD.showErrorMessage(ErrorMessage: "该用户未注册!!!", ForDuration: 2.0, completion: nil)
                        self?.vaildCodeBtn.isEnabled = true
                        return
                    } else {
                        SVProgressHUD.showProgressMessage(ProgressMessage: "")
                        let sendVerificationCodeRequestModel = SendVerificationCodeRequestModel()
                        sendVerificationCodeRequestModel.phone = (self?.phoneTf.text)!
                        sendVerificationCodeRequestModel.type = 1
                        AppAPIHelper.login().SendVerificationCode(model: sendVerificationCodeRequestModel, complete: {[weak self] (result) in
                            SVProgressHUD.dismiss()
                            self?.vaildCodeBtn.isEnabled = true
                            if let response = result {
                                if response["result"] as! Int == 1 {
                                    self?.timer = Timer.scheduledTimer(timeInterval: 1,target:self!,selector: #selector(self?.updatecodeBtnTitle),userInfo: nil,repeats: true)
                                    self?.timeStamp = String.init(format: "%ld", response["timeStamp"] as!  Int)
                                    self?.vToken = String.init(format: "%@", response["vToken"] as! String)
                                }
                            }
                        }, error: { (error) in
                            SVProgressHUD.showErrorMessage(ErrorMessage: error.userInfo["NSLocalizedDescription"] as! String, ForDuration: 2.0, completion: nil)
                            self?.vaildCodeBtn.isEnabled = true
                        })
                    }
                }
            }, error: { (error) in
                SVProgressHUD.showErrorMessage(ErrorMessage: error.userInfo["NSLocalizedDescription"] as! String, ForDuration: 2.0, completion: nil)
                self.vaildCodeBtn.isEnabled = true
            })
        }
    }
    
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
    //MARK: 重置密码
    @IBAction func doreset(_ sender: Any) {
        
        if !isPassWord(pwd: first_input.text!) {
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入6位字符以上密码", ForDuration: 2.0, completion: nil)
            return
        }
        if !isPassWord(pwd: second_input.text!) {
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入6位字符以上密码", ForDuration: 2.0, completion: nil)
            return
        }
        if first_input.text != second_input.text {
            SVProgressHUD.showErrorMessage(ErrorMessage: "两次密码不一致", ForDuration: 2.0, completion: nil)
            return
        }
        
        let string = "yd1742653sd" + self.timeStamp + self.codeTf.text! + self.phoneTf.text!
        if string.md5_string() != self.vToken{
            SVProgressHUD.showErrorMessage(ErrorMessage: "验证码不正确", ForDuration: 0.5, completion:nil)
            return
        }

        // #274
        let model = ResetPassWdRequestModel()
        model.phone = self.phoneTf.text!
        model.pwd = self.first_input.text!.md5_string()
        AppAPIHelper.login().ResetPasswd(model: model, complete: { (result)  in
            if let response = result{
                if response["result"] as! Int == 1{
                    // 重置成功
                    SVProgressHUD.showSuccessMessage(SuccessMessage: "重置成功", ForDuration: 2.0, completion: {
                        _ =  self.navigationController?.popViewController(animated: true)
                    })
                }
            }
        }, error: errorBlockFunc())
    }
    
    
}
