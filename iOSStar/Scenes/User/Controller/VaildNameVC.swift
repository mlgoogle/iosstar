//
//  VaildNameVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class VaildNameVC:  BaseTableViewController {

    //身份证号
    @IBOutlet weak var card: UITextField!
    //姓名
    @IBOutlet weak var name: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "实名认证"

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   
}
