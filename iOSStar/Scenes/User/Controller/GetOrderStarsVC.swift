//
//  GetOrderStarsVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/9.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh

class GetOrderStarsVC: BaseCustomPageListTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我预约的明星"
    
       
    }
    override func didRequest(_ pageIndex: Int) {
        
        AppAPIHelper.user().getfriendList(accid: UserDefaults.standard.object(forKey: "phone") as! String, createtime:  "0", complete: { (result) in
            
            let Model : StarListModel = result as! StarListModel
            self.didRequestComplete( Model.list as AnyObject)

            return
            
        }) { (error)  in
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
  
  
    // MARK: - Table view data source

    
  



}
