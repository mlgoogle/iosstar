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
    var titles = ["名称/代码","委托量","价格","类型/状态"]
    var orderData:[EntrustListModel]?
    var showNav = false
    var index : Int = 1
    var header:MJRefreshNormalHeader?
    var footer:MJRefreshAutoFooter?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if showNav{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            title = "交易明细"
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()//NSNotification.Name(rawValue: "sellScucess")
//        NSNotification.default.
        
      NotificationCenter.default.addObserver(self, selector: #selector(sellScucess(_:)), name: Notification.Name(rawValue:"sellScucess"), object: nil)
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.className())
        
        header = MJRefreshNormalHeader(refreshingBlock: {
            
            self.index = 1
            self.requestOrder(isRefresh: true)
        })
        
        footer = MJRefreshAutoFooter(refreshingBlock: {
            self.index = self.index + 1
            self.requestOrder(isRefresh: false)
            
        })
        tableView.mj_header = header
        tableView.mj_footer = footer
        header?.beginRefreshing()
//        requestOrder(isRefresh: true)
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
        requestModel.start = Int32((index - 1) * 10)
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
    
    func sellScucess(_ LoginSuccess : NSNotification){
    
     header?.beginRefreshing()
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
