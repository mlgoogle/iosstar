//
//  AllOrderViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class AllOrderViewController: DealBaseViewController {
    
    var identifiers = ["DealTitleMenuCell", NoDataCell.className()]
    @IBOutlet weak var tableView: UITableView!
    var titles = ["名称/代码","委托价/成交","价格","状态"]
    var orderData:[OrderListModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.className())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func requestOrder() {
        let requestModel = OrderRecordRequestModel()
        AppAPIHelper.dealAPI().requestOrderList(requestModel: requestModel, OPCode: .historyOrder, complete: { (response) in
            if let models = response as? [OrderListModel] {
                self.orderData = models
                if models.count > 0 {
                    self.identifiers.removeLast()
                    self.identifiers.append("DealSingleRowCell")
                }
                self.tableView.reloadData()
            }
        }) { (error) in
            self.didRequestError(error)
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
