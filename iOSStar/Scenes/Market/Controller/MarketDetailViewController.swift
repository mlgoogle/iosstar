
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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "112222"
        tableView.register(MarketDetailMenuView.self, forHeaderFooterViewReuseIdentifier: "MarketDetailMenuView")
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
