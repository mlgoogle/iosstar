//
//  GetOrderStarsVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/9.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh
class GetOrderStarsVCCell: UITableViewCell {
    
}
class GetOrderStarsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var header:MJRefreshNormalHeader?
    var footer:MJRefreshAutoNormalFooter?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我预约的明星"
        tableView.dataSource = self
        tableView.delegate = self
        initData()
    
        header = MJRefreshNormalHeader(refreshingBlock: {
         
            self.dataList()
           
        })
        tableView.mj_header = header
        
        footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            
           self.dataList()
          
        })
        tableView.mj_footer = footer
    }
    func dataList(){
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
  
    func initData(){
    
        AppAPIHelper.friend().getorderstars(phone: "18643803462", starcode: "", complete: { (result) in
            
        }) { (error) in
            
        }
    }
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

   
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell")
        return cell!
    }
  



}
