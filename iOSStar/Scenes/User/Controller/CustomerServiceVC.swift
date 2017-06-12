//
//  CustomerServiceVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/9.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class CustomerServiceVC: UITableViewController {

    @IBOutlet weak var CustomerQQLabel: UILabel!
    @IBOutlet weak var weChatLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
         title = "客服中心"
        let view = UIView.init()
        view.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = view
        self.tableView.allowsSelection = false
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
