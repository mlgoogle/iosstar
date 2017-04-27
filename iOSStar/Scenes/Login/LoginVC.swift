//
//  LoginVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class LoginVC: UITableViewController {

    //手机号
    @IBOutlet weak var passPwd: UITextField!
    // 登录密码
    @IBOutlet weak var phone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()

    }
    func initNav(){
    
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        btn.setBackgroundImage(UIImage.init(named: "close"), for: .normal)
        let navaitem = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = navaitem
        btn.addTarget(self, action: #selector(didClose), for: .touchUpInside)
    }
    func didClose(){
        
        self.dismissController()
    }
      //登录
    @IBAction func doLogin(_ sender: Any) {
        ShareDataModel.share().isdoregist = false
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

}
