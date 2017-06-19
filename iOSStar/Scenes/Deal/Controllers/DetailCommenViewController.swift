//
//  DetailCommenViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh
class DetailCommenViewController: DealBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var dealTitles = ["名称/代码","成交时间","成交价/成交量","状态/成交额"]
    var entrustTitles = ["名称/代码","委托价/时间","委托量/成交量","状态"]
    var header:MJRefreshNormalHeader?
    var footer:MJRefreshAutoStateFooter?
    var count = 0
    var orderData:[OrderListModel]?
    var entrustData:[EntrustListModel]?
    var type:AppConst.DealDetailType = .allEntrust
    var identifiers = ["DealSelectDateCell","DealTitleMenuCell",NoDataCell.className()]
    var sectionHeights:[CGFloat] = [80.0, 36.0, 500]
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false

//        if type.hashValue < 2 {
            identifiers.removeFirst()
            sectionHeights.removeFirst()
//        }

        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.className())
        
        header = MJRefreshNormalHeader(refreshingBlock: { 
            
            self.count = 0
            self.footer?.endRefreshing()
            self.requestData(isRefresh: true)
        })
        
        footer = MJRefreshAutoStateFooter(refreshingBlock: {
            self.header?.endRefreshing()
            self.requestData(isRefresh: false)
        })
        footer?.stateLabel.text = "只展示最近7天历史数据"
        tableView.mj_header = header
        tableView.mj_footer = footer
        footer?.isHidden = true

        requestData(isRefresh: true)
    }

    
    func endRefresh(count:Int) {
        if header?.state == .refreshing {
            header?.endRefreshing()
        }
        if footer?.state == .refreshing {
            footer?.endRefreshing()
        }
        if count < 10 {
            var titile = ""
            if checkHistory() {
                titile = "只展示最近7天历史数据"
            } else {
                titile = "没有更多数据"
            }
            if count != 0 {
                footer?.setTitle(title, for: .noMoreData)
                footer?.state = .noMoreData
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func requestData(isRefresh:Bool) {

        let opcode = SocketConst.OPCode(rawValue: type.rawValue)
        guard opcode != nil else {
            return
        }
        if checkIfEntrust() {
            let requestModel = DealRecordRequestModel()
            requestModel.start = Int32(count)
            
            requestEntrustList(isRefresh: isRefresh,requestModel:requestModel,opcode:opcode!)
        } else {
            let requestModel = OrderRecordRequestModel()
            requestModel.start = Int32(count)
            if type == .todayComplete   {
                requestModel.status = 2
            } else {
                requestModel.status = 3

            }
            requestOrderData(isRefresh: isRefresh, requestModel: requestModel,opcode:opcode!)
        }
    }
    
    
    func requestOrderData(isRefresh:Bool, requestModel:OrderRecordRequestModel, opcode:SocketConst.OPCode) {

        AppAPIHelper.dealAPI().requestOrderList(requestModel: requestModel, OPCode: opcode, complete: { (response) in
            if let models = response as? [OrderListModel]{
                if isRefresh {
                    self.orderData = models
                } else {
                    self.orderData?.append(contentsOf: models)
                }
                self.checkCount(count: models.count)
            }
        }) { (error) in
            self.didRequestError(error)
            self.endRefresh(count:1)
        }
    }
    
    
    func requestEntrustList(isRefresh:Bool, requestModel:DealRecordRequestModel, opcode:SocketConst.OPCode) {
        
        AppAPIHelper.dealAPI().requestEntrustList(requestModel: requestModel, OPCode: opcode, complete: { (response) in
            if let models = response as? [EntrustListModel]{
                if isRefresh {
                    self.entrustData = models
                } else {
                    self.entrustData?.append(contentsOf: models)
                }
                self.checkCount(count:models.count)
            }
        }) { (error) in
            self.didRequestError(error)
            self.endRefresh(count:1)
        }
    }
    
    
    func showDatePicker() {
        let vc = YD_DatePickerViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    func checkCount(count:Int) {
        if count < 10 && !checkHistory() {
            footer?.isHidden = true
        } else {
            footer?.isHidden = false
        }
        self.count += count
        identifiers.removeLast()
        sectionHeights.removeLast()
        if count == 0 {
            sectionHeights.append(500)
            identifiers.append(NoDataCell.className())
        } else {
            sectionHeights.append(80.0)
            identifiers.append("DealDoubleRowCell")
        }
        endRefresh(count:count)
        
        tableView.reloadData()
    }
    func checkHistory() -> Bool {
        return type == AppConst.DealDetailType.allEntrust || type == AppConst.DealDetailType.allDeal
    }
    
    func checkIfEntrust() -> Bool {
        return type == AppConst.DealDetailType.todayEntrust || type == AppConst.DealDetailType.allEntrust
    }
}

extension DetailCommenViewController :UITableViewDelegate, UITableViewDataSource, SelectDateDelegate{
    func startSelect(isStart:Bool) {
        showDatePicker()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return identifiers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == identifiers.count - 1 {
            return count == 0 ? 1 : count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.section]!, for: indexPath)
//        if type.rawValue > AppConst.DealDetailType.todayEntrust.rawValue{
//           
//            switch indexPath.section {
//            case 0:
//                if let dateCell = cell as? DealSelectDateCell {
//                    dateCell.delegate = self
//                }
//            case 1:
//                if let menuCell = cell as? DealTitleMenuCell {
//                    if type.rawValue == AppConst.DealDetailType.allEntrust.rawValue {
//                        menuCell.setTitles(titles: entrustTitles)
//                    } else {
//                        menuCell.setTitles(titles: dealTitles)
//                    }
//                }
//            default:
//                break
//            }
//
//        } else {
            switch indexPath.section {
            case 0:
                if let menuCell = cell as? DealTitleMenuCell {
                    if checkIfEntrust() {
                        menuCell.setTitles(titles: entrustTitles)
                    } else {
                        menuCell.setTitles(titles: dealTitles)
                    }
                }
            case identifiers.count - 1:
                if let listCell = cell as? DealDoubleRowCell {
                    if  checkIfEntrust() {
                        listCell.setEntruset(model:entrustData![indexPath.row])
                    } else {
                        listCell.setOrderModel(model:orderData![indexPath.row])
                    }
                } else if let nodataCell = cell as? NoDataCell {
                    nodataCell.setImageAndTitle(image: UIImage(named: "nodata_record"), title: "当前还没有相关记录")
                }
            default:
                break
            }
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return sectionHeights[indexPath.section]
    }
}
