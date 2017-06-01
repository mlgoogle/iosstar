//
//  StatementVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/28.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class StatementVC: BaseTableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "免责声明"
       
    }

  

   

}
