
//
//  BuyYetViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD
class BuyYetViewController: DealBaseViewController {
    var isRefresh = true
    var header:MJRefreshNormalHeader?
    var footer:MJRefreshAutoNormalFooter?
    var page : Int = 0
    @IBOutlet weak var tableView: UITableView!
    var identifiers = ["DealTitleMenuCell", NoDataCell.className()]
//    var titles = ["名称/市值（元）","持有/可转（秒）","现价/成本（秒）","盈亏（元）"]
    var titles = ["名称","代码","数量",""]
//    var sectionHeights:[CGFloat] = [100.0, 38, 80.0]
    var sectionHeights:[CGFloat] = [38, 80.0]

    var orderData:[StarInfoModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        header = MJRefreshNormalHeader(refreshingBlock: {
            self.page = 1
            self.requestOrder()
           
        })
        
        tableView.mj_header = header
        footer?.endRefreshing()
      
        footer = MJRefreshAutoNormalFooter(refreshingBlock: {
             self.page += 1
            self.isRefresh = false
            self.requestOrder()
        })
          footer?.isHidden = true
        tableView.mj_footer = footer
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.className())
        requestOrder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func endRefresh() {
        if header?.state == .refreshing {
            header?.endRefreshing()
        }
        if footer?.state == .refreshing {
            footer?.endRefreshing()
        }
    }
    
    func requestOrder() {
        
        let requestModel = StarMailListRequestModel()
        requestModel.status = 1
        requestModel.startPos = (page - 1) * 10
        AppAPIHelper.user().requestStarMailList(requestModel: requestModel, complete: { (result) in
            if let Model = result as? StarListModel {
                self.orderData = Model.depositsinfo
                self.tableView.reloadData()
                self.identifiers.removeLast()
                self.identifiers.append(PositionStarCell.className())
                
            }
        }) { (error) in
            self.endRefresh()
        }
    }
    
}

extension BuyYetViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return identifiers.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sectionHeights[indexPath.section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == identifiers.count - 1 {
            return orderData?.count ?? 1
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.section]!, for: indexPath)

        switch indexPath.section {
        case 0:
            let proCell = cell as! DealTitleMenuCell
            proCell.setTitles(titles:titles)
        case 1:
            if let nodataCell = cell as? NoDataCell {
                nodataCell.setImageAndTitle(image: UIImage(named: "nodata_record"), title: "当前没有相关记录")

            } else if let positionCell = cell as? PositionStarCell {
                positionCell.setStar(model:orderData![indexPath.row])
            }
        default:
            break
        }
        return cell
    }
}
