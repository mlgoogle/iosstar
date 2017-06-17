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
    var footer:MJRefreshAutoFooter?
    var fansList:[OrderFansListModel]?
    var isBuy = true
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = tableView
        tableView.bounces = true
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 450))
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.className())
        tableView.register(FansListHeaderView.self, forHeaderFooterViewReuseIdentifier: "FansListHeaderView")
        automaticallyAdjustsScrollViewInsets = false
        requestFansList()
        footer = MJRefreshAutoFooter(refreshingBlock: { 
            self.requestFansList()
            
        })
        tableView.mj_footer = footer
    }
    
    func endRefres(count:Int) {
        footer?.endRefreshing()
        if count < 10 {
         footer?.isHidden = true
        }
    }
    
    func requestFansList() {
        let requestModel = FanListRequestModel()
        requestModel.buySell = 0
        
        requestModel.start = Int32(fansList?.count ?? 0)
        AppAPIHelper.marketAPI().requestOrderFansList(requestModel: requestModel, complete: { (response) in
            if let models = response as? [OrderFansListModel]{
                if  self.fansList?.count ?? 0 != 0 {
                    
                    self.fansList?.append(contentsOf: models)
                } else{
                    
                    self.fansList = models
                }
                self.endRefres(count:self.fansList!.count)

                self.tableView.reloadData()
            }
            self.endRefres(count:1)
        }) { (error) in
            self.didRequestError(error)
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
            isBuy = true
        } else {
            isBuy = false
        }
        tableView.reloadData()
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
