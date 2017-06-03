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

        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 90 - 64 - 44), style: .grouped)

        return tableView
    }()
    
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

    }

    
    func requestStarList(type:Int, sortType:AppConst.SortType) {
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
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource == nil ? 0 : dataSource!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubViewItemCell", for: indexPath) as! SubViewItemCell
        cell.setupData(model: dataSource![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectItem(starModel: dataSource![indexPath.row])
    }
}
