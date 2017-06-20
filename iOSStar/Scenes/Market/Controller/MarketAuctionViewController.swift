//
//  MarketAuctionViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketAuctionViewController: MarketBaseViewController {
    var index = 0
    var count = 540
    var endTime:Int64 = 0
    var headerCell:AuctionHeaderCell?
    var countModel:PositionCountModel?
    var buySell:Int32 = 1
    var fansList:[FansListModel]?
    var statusModel:AuctionStatusModel?
    var buySellModel:BuySellCountModel?
    var imageUrl = ""
    var totalCount:Int = 0
    var sectionHeighs = [224,35,140,155,80]
    var identifiers:[String] = [AuctionImageViewCell.className(),AuctionTimeCell.className(),AuctionPositionInfoCell.className(),AuctionProgreseeCell.className(),MarketAuctionCell.className()]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = tableView
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 450))

        tableView.register(FansListHeaderView.self, forHeaderFooterViewReuseIdentifier: "FansListHeaderView")
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.className())

        requestAuctionSattus()
        requestFansList()
        requetTotalCount()
        requestPositionCount()
        requestPercent()
    }

    func initCountDownBlock() {

        YD_CountDownHelper.shared.marketBuyOrSellListRefresh = { [weak self] (result)in
            self?.requestFansList()
            self?.requestPositionCount()
            self?.requestPercent()
        }
        
        
        YD_CountDownHelper.shared.countDownRefresh = { [weak self] (result)in
            guard self != nil  else {
                return
            }
            self?.count -= 1
            if (self?.count)! > 0 {
                self?.tableView.reloadSections(IndexSet(integer: 1), with: .none)
            } else {
                self?.tableView.reloadSections(IndexSet(integer: 1), with: .none)
            }
            
        }
    }
    func refreshSatus() {
        guard  statusModel != nil else {
            return
        }
        if statusModel!.status && statusModel!.remainingTime > 0 {
            endTime = Int64(Date().timeIntervalSince1970) + statusModel!.remainingTime + YD_CountDownHelper.shared.timeDistance
            initCountDownBlock()
        } else {
            self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }

    }
    
    func requestPositionCount() {
        guard starCode != nil else {
            return
        }
        let r = PositionCountRequestModel()
        r.starcode = starCode!
        AppAPIHelper.marketAPI().requestPositionCount(requestModel: r, complete: { (response) in
            if let model = response as? PositionCountModel {
                self.countModel = model
            self.tableView.reloadSections(IndexSet(integer: 2), with: .none)
            }
        }) { (error) in
            self.countModel = PositionCountModel()
            self.tableView.reloadSections(IndexSet(integer: 2), with: .none)
        }
    }
    
    func requestPercent() {
        guard starCode != nil else {
            return
        }
        let requestModel = BuySellPercentRequest()
        requestModel.symbol = starCode!
        AppAPIHelper.marketAPI().requstBuySellPercent(requestModel: requestModel, complete: { (response) in
            if let model = response as? BuySellCountModel{
                self.buySellModel = model                
                self.tableView.reloadSections(IndexSet(integer: 3), with: .none)

            }
            
        }) { (error) in
            
            self.tableView.reloadSections(IndexSet(integer: 3), with: .none)
        }

    }

    
    
    
    func requestAuctionSattus() {
        guard starCode != nil else {
            return
        }
        let model = AuctionStatusRequestModel()
        model.symbol = starCode!
        AppAPIHelper.marketAPI().requestAuctionStatus(requestModel: model, complete: { (response) in
            if let model = response as? AuctionStatusModel {
                self.statusModel = model
                self.refreshSatus()
            
            }
        }) { (error) in
            self.refreshSatus()
        }
    }

    func requestFansList() {
        guard starCode != nil else {
            return
        }
        let requestModel = FanListRequestModel()
        requestModel.buySell = buySell
        requestModel.symbol = starCode!
        AppAPIHelper.marketAPI().requestEntrustFansList(requestModel: requestModel, complete: { (response) in
            if let models = response  as? [FansListModel] {
                self.fansList = models
                self.sectionHeighs.removeLast()
                self.sectionHeighs.append(80)
                self.identifiers.removeLast()
                self.identifiers.append(MarketAuctionCell.className())
                self.tableView.reloadSections(IndexSet(integer: 4), with: .none)
            }
        }) { (error) in
            self.sectionHeighs.removeLast()
            self.sectionHeighs.append(500)
            self.fansList?.removeAll()
            self.identifiers.removeLast()
            self.identifiers.append(NoDataCell.className())
            self.tableView.reloadSections(IndexSet(integer: 4), with: .none)
        }
    }
    
    func requetTotalCount() {
        guard starCode != nil else {
            return
        }
        AppAPIHelper.marketAPI().requestTotalCount(starCode: starCode!, complete: { (response) in
            if let model = response as? StarTotalCountModel {
                self.totalCount = Int(model.star_time)
            }
            
        }) { (error) in
            
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshSatus()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        YD_CountDownHelper.shared.countDownRefresh = nil
        YD_CountDownHelper.shared.marketBuyOrSellListRefresh = nil

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension MarketAuctionViewController:UITableViewDataSource, UITableViewDelegate, SelectFansDelegate,RefreshImageDelegate{
    func refreshImage(imageUrl: String) {
        self.imageUrl = imageUrl
        self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    func selectAtIndex(index: Int) {
        if index == 0 {
            buySell = 1
        } else {
            buySell = -1
        }
        self.index = index
        requestFansList()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 4 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FansListHeaderView") as! FansListHeaderView
            headerView.delegate = self
            headerView.settitles(titles: ["买入","卖出"])
            headerView.selectIndex(index: index)
            headerView.isShowImage = false
            return headerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return fansList?.count ?? 1
        }
        return  1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 4 {
            return 45
        }
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(sectionHeighs[indexPath.section])
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return identifiers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.section], for: indexPath)
        switch indexPath.section {
        case 0:
            if let imageCell =  cell as? AuctionImageViewCell {
                
                imageCell.setImageUrl(url: imageUrl)
            }
        case 1:
            if let timeCell = cell as? AuctionTimeCell {
                timeCell.setTimeText(text: YD_CountDownHelper.shared.getTextWithStartTime(closeTime: Int(self.endTime)))
            }
        case 2:
            if let positionCell = cell as? AuctionPositionInfoCell {
                positionCell.setPositionCountModel(model: countModel, starCode: starCode!, starName: starName)
            }
            
        case 3:
            if let progressCell = cell as? AuctionProgreseeCell {
                progressCell.setPercent(model: buySellModel, totalCount: totalCount)
            }
        case 4:
            if let nodataCell = cell as? NoDataCell {
                nodataCell.setImageAndTitle(image: UIImage(named: "nodata_fanslist"), title: nil)
            } else if let fansCell = cell as? MarketAuctionCell {
                fansCell.setFans(model:fansList![indexPath.row])

            }
        default:
            break
        }
        

        return cell
    }
}
