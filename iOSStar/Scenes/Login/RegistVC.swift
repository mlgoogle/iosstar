//
//  RegistVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class RegistVC: UITableViewController {
    @IBOutlet weak var codeTf: UITextField!

    @IBOutlet var phoneTf: UITextField!
    //定时器
    private var timer: Timer?
    //验证码
    @IBOutlet weak var vaildCodeBtn: UIButton!
     //验证码
    private var codeTime = 60
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ShareDataModel.share().isdoregist == true ? "注册" : "忘记密码"
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
        vaildCodeBtn.backgroundColor = UIColor(hexString: "185CA5")
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
    
    @IBAction func sureClick(_ sender: Any) {
        
        if checkTextFieldEmpty([codeTf]){
        
              ShareDataModel.share().phone = phoneTf.text!
            self.performSegue(withIdentifier: "pushInputPwd", sender: nil)
        }
    }

}
