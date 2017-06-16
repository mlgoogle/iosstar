//
//  MenuSubViewCell.swift
//  iOSStar
//
//  Created by J-bb on 17/4/27.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh
protocol SubViewItemSelectDelegate {
    func selectItem(starModel:MarketListStarModel)
}
class MenuSubViewCell: UICollectionViewCell {
    var header:MJRefreshNormalHeader?
    var footer:MJRefreshAutoNormalFooter?
    lazy var tableView:UITableView = {

        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 90 - 24 - 44), style: .grouped)

        return tableView
    }()
    

    var type = 0
    var sortType = AppConst.SortType.down.rawValue
    var isLoadMore = true
    var dataSource:[MarketListStarModel]?
    var delegate:SubViewItemSelectDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
    }
    func addSubViews() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hexString: "FAFAFA")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SubViewItemCell.self, forCellReuseIdentifier: "SubViewItemCell")
        contentView.addSubview(tableView)
        header = MJRefreshNormalHeader(refreshingBlock: { 
            self.requestCustomData(type: 0, sortType: AppConst.SortType(rawValue: self.sortType)!)
            YD_CountDownHelper.shared.marketIdentifier = 0
        })
        tableView.mj_header = header
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.className())

    }

    
    func requestStarList(type:Int, sortType:AppConst.SortType) {
        self.sortType = sortType.rawValue
        self.type = type
        if type == 0 {
            requestOptional()
        } else {
            requestCustomData(type: type, sortType:sortType)
        }
    }
    func requestOptional() {
        AppAPIHelper.marketAPI().requestOptionalStarList(startnum: 1, endnum: 10, complete: { (response) in
            self.reloadWithData(response: response)
        }, error: { (error) in
            self.reloadWithData(response: nil)
        })
    }
    func requestCustomData(type:Int, sortType:AppConst.SortType) {
        let requetModel = StarListRequestModel()
        requetModel.sort = sortType.rawValue

        AppAPIHelper.marketAPI().requestStarList(requestModel: requetModel, complete: { (response) in
            self.reloadWithData(response: response)
        }) { (error) in
            self.reloadWithData(response: nil)
        }
    }
    func reloadWithData(response:AnyObject?) {
        if header?.state == .refreshing {
            header?.endRefreshing()
        }

        if let models = response as? [MarketListStarModel] {
            dataSource = models
        } else {
            dataSource?.removeAll()
        }
        tableView.reloadData()

    }
}

extension MenuSubViewCell:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataSource?.count ?? 0 == 0 {
            return 500
        }
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataSource?.count ?? 0 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataCell.className(), for: indexPath) as! NoDataCell
            var string = "添加明星，就可以实时跟踪您关心的行情。"
            if type == 0 {
                string = "行情信息加载中"
            }
            cell.setImageAndTitle(image: UIImage(named: "nodata_comment"), title: string)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubViewItemCell", for: indexPath) as! SubViewItemCell
        cell.setupData(model: dataSource![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard dataSource != nil else {
            return
        }
        delegate?.selectItem(starModel: dataSource![indexPath.row])
    }
}
