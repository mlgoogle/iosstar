//
//  wealthVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class WealthVC: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView.init()
        view.backgroundColor = UIColor.clear
        title = "我的资产"
        self.tableView.tableFooterView = view
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1: 2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 269 : 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell")
        if indexPath.section == 0{
        return cell!
            
        }
        if indexPath.section == 1{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RechareCell")
                   return cell!
            }
            if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "WithDrawCell")
                   return cell!
            }
            return cell!
            
        }
        return cell!
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
       
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.section == 1 {
            if indexPath.row == 1{
            
                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "TipBindCardVC") as! TipBindCardVC
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .custom
                vc.resultBlock = { (result) in
                     let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "BindingBankCardVC") 
                  self.navigationController?.pushViewController(vc, animated: true )
                    
                }
                self.present(vc, animated: true) {
            }
        }
            
        }
        
    }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 10 : 0.0001
    }
}
