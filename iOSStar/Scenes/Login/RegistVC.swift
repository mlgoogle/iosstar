//
//  RegistVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class RegistVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ShareDataModel.share().isdoregist == false ? "注册" : "忘记密码"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sureClick(_ sender: Any) {
    }

  

}
