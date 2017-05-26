//
//  SystemMessageVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/24.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SystemMessageVC: BasePageListTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "系统消息"
        tableView.separatorStyle = .none
       
    }


    override func didRequest(_ pageIndex: Int) {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") 
        cell?.selectionStyle = .none
        return cell!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
     override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 10 : 5
    }
     override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}
