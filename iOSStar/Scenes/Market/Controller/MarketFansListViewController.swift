//
//  MarketFansListViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh

class MarketFansListViewController: MarketBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var index:Int = 0
    var fansList:[FansListModel]?
    var isBuy = true
    var buySell = 1
    var isRefresh = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scrollView = tableView
        tableView.bounces = true
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.className())
        tableView.register(FansListHeaderView.self, forHeaderFooterViewReuseIdentifier: "FansListHeaderView")
        automaticallyAdjustsScrollViewInsets = false
        requestFansList()
        footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.isRefresh = false
            self.requestFansList()
            
        })
        tableView.mj_footer = footer
        title = "委托排行榜"
    }
    
    func endRefres(count:Int) {
        footer?.endRefreshing()
        if count < 10 {
         footer?.isHidden = true
        }
    }
    
    func requestFansList() {

        
        guard starCode != nil else {
            return
        }
        let requestModel = FanListRequestModel()
        requestModel.buySell = Int32(buySell)
        requestModel.symbol = starCode!
        if isRefresh  {
            requestModel.start = 1
        } else {
            requestModel.start = Int32(fansList?.count ?? 0)
        }
        AppAPIHelper.marketAPI().requestEntrustFansList(requestModel: requestModel, complete: { (response) in
            if let models = response as? [FansListModel]{
                
                if self.isRefresh {
                    self.fansList = models
                } else {
                    self.fansList?.append(contentsOf: models)
                }
                self.endRefres(count:self.fansList!.count)
                self.tableView.reloadData()
            }
        }) { (error) in
            self.endRefres(count:1)

        }

  
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension MarketFansListViewController:UITableViewDelegate, UITableViewDataSource, SelectFansDelegate {
    
    func selectAtIndex(index: Int) {
        self.index = index
        if index == 0 {
            buySell = 1
        } else {
            buySell = -1
        }

        isRefresh = true
        requestFansList()
         //doSomething
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if fansList?.count ?? 0 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataCell.className(), for: indexPath) as! NoDataCell
            cell.setImageAndTitle(image: UIImage(named: "nodata_fanslist"), title: nil)
            return cell
        }
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarketSBFansCell", for: indexPath) as! MarketSBFansCell
            cell.setOrderFans(model: fansList![indexPath.row], isBuy: isBuy)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketFansCell", for: indexPath) as! MarketFansCell
        cell.setOrderFans(model: fansList![indexPath.row], isBuy: isBuy,index:indexPath.row)

        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  fansList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FansListHeaderView") as! FansListHeaderView
        header.delegate = self
        header.selectIndex(index:index)
        return header
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if fansList?.count ?? 0 == 0 {
            return 500
        }
        return 80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 63
    }
    
}
