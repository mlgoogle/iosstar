
//
//  BuyYetViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class BuyYetViewController: DealBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var identifiers = ["DealPropertyCell","DealTitleMenuCell", NoDataCell.className()]
    var titles = ["名称/市值（元）","持有/可转（秒）","现价/成本（秒）","盈亏（元）"]
    var sectionHeights:[CGFloat] = [100.0, 38, 80.0]
    
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
                self.tableView.reloadData()
                self.identifiers.removeLast()
                self.identifiers.append(DealDoubleRowCell.className())
            }
            
        }) { (error) in
            self.didRequestError(error)
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
        case 1:
            let proCell = cell as! DealTitleMenuCell
            proCell.setTitles(titles:titles)
        case 2:
            
            if orderData?.count ?? 0 == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: NoDataCell.className(), for: indexPath) as! NoDataCell
                
                cell.setImageAndTitle(image: UIImage(named: "nodata_record"), title: "当前没有相关记录")
                return cell
            }
        default:
            break
        }
        return cell
    }
}
