
//
//  MarketDetailViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var handleMenuView: ImageMenuView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomTitle(title: "柳岩（423412）")
        
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(MarketDetailMenuView.self, forHeaderFooterViewReuseIdentifier: "MarketDetailMenuView")
        handleMenuView.titles = ["求购","转让","粉丝见面会","自选"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
extension MarketDetailViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MarketDetailMenuView") as! MarketDetailMenuView
        return  view
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            
            return kScreenHeight - 50 - 64 - 50
        }
        return 305
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            
            return 0.001
        }
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarketDetailSubViewCell", for: indexPath) as! MarketDetailSubViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketDetailCell", for: indexPath) as! MarketDetailCell
        cell.setData()
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
