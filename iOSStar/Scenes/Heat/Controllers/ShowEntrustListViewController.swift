//
//  ShowEntrustListViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/16.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh

class ShowEntrustListViewController: UIViewController {
    var starCode:String?
    var buySell:Int32 = 0
    var dataSource:[FansListModel]?
    var footer:MJRefreshAutoNormalFooter?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "委托排行榜"
        requestFansList()
        
        footer = MJRefreshAutoNormalFooter {

            self.requestFansList()
        }
        tableView.mj_footer = footer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func requestFansList() {
        guard starCode != nil else {
            return
        }
        let requestModel = FanListRequestModel()
        requestModel.buySell = buySell
        requestModel.symbol = starCode!

            requestModel.start = Int32(dataSource?.count ?? 0)
        AppAPIHelper.marketAPI().requestEntrustFansList(requestModel: requestModel, complete: { (response) in
            if let models = response  as? [FansListModel] {
                self.dataSource = models
                self.tableView.reloadData()
                self.endRefres(count: 0)
            }
        }) { (error) in
            self.endRefres(count:0)
        }
    }
    func endRefres(count:Int) {
        footer?.endRefreshing()

        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ShowEntrustListViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketAuctionCell.className(), for: indexPath) as! MarketAuctionCell
        cell.setFans(model:dataSource![indexPath.row])
        return cell
    }
    
}
