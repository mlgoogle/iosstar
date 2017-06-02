//
//  MarketAuctionViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketAuctionViewController: MarketBaseViewController {

    
    var timeLabel:UILabel?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = tableView
        tableView.register(FansListHeaderView.self, forHeaderFooterViewReuseIdentifier: "FansListHeaderView")

        
        YD_CountDownHelper.shared.countDownRefresh = { [weak self] (result)in
     

        }
        YD_CountDownHelper.shared.marketBuyOrSellListRefresh = { [weak self] (result)in
            
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("--------countDownRefresh---------开始----------------")

        YD_CountDownHelper.shared.countDownRefresh = { [weak self] (result)in
            
            
        }
        YD_CountDownHelper.shared.marketBuyOrSellListRefresh = { [weak self] (result)in
            
            
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("--------countDownRefresh---------结束----------------")

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension MarketAuctionViewController:UITableViewDataSource, UITableViewDelegate, SelectFansDelegate{
    
    func selectAtIndex(index: Int) {
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FansListHeaderView") as! FansListHeaderView
        headerView.delegate = self
        headerView.settitles(titles: ["买入","卖出"])
        headerView.isShowImage = false
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.001
        }
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 580.5
        }
        return 90
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
          
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarketAuctionCell", for: indexPath) as! MarketAuctionCell
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionHeaderCell", for: indexPath) as! AuctionHeaderCell
        
        return cell
    }
}
