//
//  MarketAuctionViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh
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
    var sectionHeighs = [224,35,140,155,80]
    var isRefresh = true
    

    var isFirst = true
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

        
        footer = MJRefreshAutoNormalFooter {
            self.isRefresh = false
            self.requestFansList()
        }
        tableView.mj_footer = footer
    }

    func initCountDownBlock() {

        YD_CountDownHelper.shared.marketBuyOrSellListRefresh = { [weak self] (result)in
            self?.isRefresh = true
            self?.requestFansList()
            self?.requestPositionCount()
            self?.requestPercent()
        }
        
        
        YD_CountDownHelper.shared.countDownRefresh = { [weak self] (result)in
            guard self != nil  else {
                return
            }
            self?.count -= 1
            self!.reloadSections(section: 1)

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

            self.reloadSections(section: 1)
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
                self.reloadSections(section: 2)
            }
        }) { (error) in
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

                self.reloadSections(section: 3)
            }
            
        }) { (error) in
            
                self.reloadSections(section: 3)
        }

    }

    
    func reloadSections(section:Int) {
        objc_sync_enter(self)
        tableView.reloadSections(IndexSet(integer: section), with: .none)
        objc_sync_exit(self)
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
                self.perform(#selector(self.refreshSatus), with: nil, afterDelay: 2.0)
            
            }
        }) { (error) in
                self.perform(#selector(self.refreshSatus), with: nil, afterDelay: 2.0)
        }
    }
    func endRefres(count:Int) {
        footer?.endRefreshing()
        
        if count == 0 {
            footer?.endRefreshing()
            sectionHeighs.removeLast()
            sectionHeighs.append(500)
            fansList?.removeAll()
            identifiers.removeLast()
            identifiers.append(NoDataCell.className())
            self.reloadSections(section: 4)
        } else {
            sectionHeighs.removeLast()
            sectionHeighs.append(80)
            identifiers.removeLast()
            identifiers.append(MarketAuctionCell.className())
        }
        if count < 10 {
            footer?.isHidden = true
        } else {
            footer?.isHidden = false
        }
        
    }
    func requestFansList() {
        guard starCode != nil else {
            return
        }
        let requestModel = FanListRequestModel()
        requestModel.buySell = buySell
        requestModel.symbol = starCode!
        if isRefresh  {

            requestModel.start = 0
        } else {
            
            requestModel.start = Int32(fansList?.count ?? 0)
        }
        AppAPIHelper.marketAPI().requestEntrustFansList(requestModel: requestModel, complete: { (response) in
            if let models = response  as? [FansListModel] {
                if  self.fansList?.count ?? 0 != 0 {
                    if self.isRefresh {
                        if self.checkIfRefresh(models: models) {
                            return
                        } else {
                            self.fansList = models
                        }
                    } else {
                        self.fansList?.append(contentsOf: models)
                    }
                    self.reloadSections(section: 4)
                    self.endRefres(count:models.count)
                    
                } else{
                    self.fansList = models
                    self.endRefres(count:self.fansList!.count)
                }
                self.isFirst = false

            }
        }) { (error) in
            self.endRefres(count:0)
        }
    }
    
    func checkIfRefresh(models:[FansListModel]) -> Bool{
        if fansList!.count == models.count && !isRefresh {
            fansList!.first!.trades!.positionId = models.first!.trades!.positionId
            
            return true
        }
        return false
        
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
        self.perform(#selector(self.refreshSatus), with: nil, afterDelay: 2.0)
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
        self.reloadSections(section: 0)
    }
    
    func selectAtIndex(index: Int) {
        if index == 0 {
            buySell = 1
        } else {
            buySell = -1
        }
        self.index = index

        YD_CountDownHelper.shared.countDownRefresh = nil

        refreshSatus()
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
        return 5
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
