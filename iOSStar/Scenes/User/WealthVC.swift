//
//  wealthVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class WealthVC: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView.init()
        view.backgroundColor = UIColor.clear
        title = "我的资产"
        self.tableView.tableFooterView = view
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.section == 1 {
            if indexPath.row == 1{
            
                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "TipBindCardVC") as! TipBindCardVC
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .custom
                vc.resultBlock = { (result) in
                     let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "BankCardVC") 
                  self.navigationController?.pushViewController(vc, animated: true )
                    
                }
                self.present(vc, animated: true) {
            }
        }
            
        }
        
    }

}
