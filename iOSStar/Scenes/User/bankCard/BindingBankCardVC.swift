//
//  BindingBankCardVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class BindingBankCardVC: UITableViewController {
    
    //持卡人姓名
    @IBOutlet var name: UITextField!
    //银行卡号
    @IBOutlet var cardNum: UITextField!
    //手机号
    @IBOutlet var phone: UITextField!
    //验证码
    @IBOutlet var vaildCode: UITextField!
    //定时器
    private var timer: Timer?
    //时间戳
    private var codeTime = 60
    //时间戳
    var timeStamp =  ""
    //token
    var vToken = ""
    //发送验证码
    @IBOutlet var SendCode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView.init()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sendCode(_ sender: Any) {
        
        
        if checkTextFieldEmpty([phone]) && isTelNumber(num: phone.text!) {
            let sendVerificationCodeRequestModel = SendVerificationCodeRequestModel()
            sendVerificationCodeRequestModel.phone = (self.phone.text!)
            sendVerificationCodeRequestModel.type = 3
            AppAPIHelper.login().SendVerificationCode(model: sendVerificationCodeRequestModel, complete: { [weak self] (result) in
                SVProgressHUD.dismiss()
                self?.SendCode.isEnabled = true
                if let response = result {
                    if response["result"] as! Int == 1 {
                        self?.timer = Timer.scheduledTimer(timeInterval: 1,target:self!,selector: #selector(self?.updatecodeBtnTitle),userInfo: nil,repeats: true)
                                                                self?.timeStamp = String.init(format: "%ld", response["timeStamp"] as!  Int)
                                                                self?.vToken = String.init(format: "%@", response["vToken"] as! String)
                    }
                  }
                }, error: { (error) in
                    self.didRequestError(error)
                    
                    self.SendCode.isEnabled = true
            })
        }
    }
    //MARK:-   更新秒数
    func updatecodeBtnTitle() {
        if codeTime == 0 {
            SendCode.isEnabled = true
            SendCode.setTitle("重新发送", for: .normal)
            codeTime = 60
            timer?.invalidate()
            SendCode.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal)
            SendCode.backgroundColor = UIColor(hexString: AppConst.Color.orange)
            return
        }
        SendCode.isEnabled = false
        codeTime = codeTime - 1
        let title: String = "\(codeTime)秒重新发送"
        SendCode.setTitle(title, for: .normal)
        SendCode.setTitleColor(UIColor.init(hexString: "000000"), for: .normal)
        SendCode.backgroundColor = UIColor(hexString: "ECECEC")
    }
    @IBAction func bingCard(_ sender: Any) {
        
        if  checkTextFieldEmpty([phone,vaildCode,cardNum,name]){
            let string = "yd1742653sd" + self.timeStamp + self.vaildCode.text! + self.phone.text!
            if string.md5_string() != self.vToken{
                SVProgressHUD.showErrorMessage(ErrorMessage: "验证码错误", ForDuration: 1.0, completion: nil)
                return
            }
            let model = BindCardListRequestModel()
            model.bankUsername = name.text!
            model.account = cardNum.text!
            AppAPIHelper.user().bindcard(requestModel: model, complete: { [weak self](result) in
              SVProgressHUD.showSuccessMessage(SuccessMessage: "绑定成功", ForDuration: 1, completion: {
                   self?.navigationController?.popViewController(animated: true)
                })
            }, error: { (error) in
                self.didRequestError(error)
            })
        }
    }
}
