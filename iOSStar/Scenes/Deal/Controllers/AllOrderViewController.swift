//
//  AllOrderViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh

class AllOrderViewController: DealBaseViewController {
    
    var identifiers = ["DealTitleMenuCell", NoDataCell.className()]
    @IBOutlet weak var tableView: UITableView!
    var titles = ["名称/代码","委托价","价格","类型/状态"]
    var orderData:[EntrustListModel]?

    var header:MJRefreshNormalHeader?
    var footer:MJRefreshAutoFooter?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.className())
        
        header = MJRefreshNormalHeader(refreshingBlock: {
            
            self.requestOrder(isRefresh: true)
        })
        
        footer = MJRefreshAutoFooter(refreshingBlock: {
            self.requestOrder(isRefresh: false)
        })
        tableView.mj_header = header
        tableView.mj_footer = footer
        requestOrder(isRefresh: true)
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
    func requestOrder(isRefresh:Bool) {
        let requestModel = DealRecordRequestModel()
        AppAPIHelper.dealAPI().requestEntrustList(requestModel: requestModel, OPCode: .historyEntrust, complete: { (response) in
            self.endRefresh()

            if let models = response as? [EntrustListModel] {
                if isRefresh {
                    self.orderData = models
                } else {
                    self.orderData?.append(contentsOf: models)
                }
                if models.count > 0 {
                    self.identifiers.removeLast()
                    self.identifiers.append("DealSingleRowCell")
                }
                self.tableView.reloadData()
            }
        }) { (error) in
            self.endRefresh()

        }

    }
}

extension AllOrderViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = ""
        if indexPath.row == 0 {
            identifier = identifiers.first!!
        } else {
            identifier = identifiers.last!!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if indexPath.row == 0 {
            let menuCell = cell as! DealTitleMenuCell
            menuCell.setTitles(titles: titles)
        } else {
            if let orderCell = cell as? DealSingleRowCell {
                orderCell.setData(model: orderData![indexPath.row - 1])
            } else if let nodataCell = cell as? NoDataCell {
                 nodataCell.setImageAndTitle(image: UIImage(named: "nodata_record"), title: "当前还没有相关记录")
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orderData?.count ?? 0 == 0 {
            
            return 2
        }
        return orderData!.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 38
        }
        
        return (orderData?.count ?? 0 == 0) ? 500 : 80
    }
}
