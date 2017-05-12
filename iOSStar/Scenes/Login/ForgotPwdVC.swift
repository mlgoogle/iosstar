//
//  FindPwdVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/21.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class ForgotPwdVC: UITableViewController {
    
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
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "重置密码"
        initLeft()
        // Do any additional setup after loading the view.
    }
      //MARK: 设置导航条
    func initLeft(){
        
        let btn : UIButton = UIButton.init(type: UIButtonType.custom)
        
        btn.setTitle("", for: UIControlState.normal)
        
        btn.setBackgroundImage(UIImage.init(named: "back"), for: UIControlState.normal )
        
        btn.addTarget(self, action: #selector(popself), for: UIControlEvents.touchUpInside)
        
        btn.frame = CGRect.init(x: 0, y: 0, width: 9, height: 17)
        
        let barItem : UIBarButtonItem = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = barItem
    }
    func popself(){
    self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if first_input.text != second_input.text{
            
            SVProgressHUD.showErrorMessage(ErrorMessage: "两次密码不一致", ForDuration: 0.5, completion: {
                
            })
         return
        }
        let string = "yd1742653sd" + self.timeStamp + self.codeTf.text! + self.phoneTf.text!
        if string.md5_string() != self.vToken{
            SVProgressHUD.showErrorMessage(ErrorMessage: "验证码不正确", ForDuration: 0.5, completion: {
                
            })
            return
        }
       AppAPIHelper.login().ResetPassWd(phone: self.phoneTf.text!, pwd: self.first_input.text!, complete: { (result) -> ()? in
        if let  response = result{
            if response["result"] as! Int == 1{
                //重置成功
                self.navigationController?.popViewController(animated: true)
            }
        }
        return()
       }) { (error) -> ()? in
        SVProgressHUD.showErrorMessage(ErrorMessage: error.userInfo["NSLocalizedDescription"] as! String, ForDuration: 0.5, completion: {
            
        })
         return()
        }
    }
  

}
