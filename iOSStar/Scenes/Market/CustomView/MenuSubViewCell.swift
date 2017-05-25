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

        let tableView = UITableView(frame: CGRect(x: 0, y: 24, width: kScreenWidth, height: kScreenHeight - 90 - 44), style: .grouped)

        return tableView
    }()
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
            self.header?.endRefreshing()
        })
        tableView.mj_header = header
        
        footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            self.footer?.endRefreshing()
            
        })
        tableView.mj_footer = footer
    
    }

    
    func requestStarList(type:Int) {
        if type == 0 {
            requestOptional()
        } else {
            requestCustomData(type: type)
        }

    }
    func requestOptional() {
        AppAPIHelper.marketAPI().requestOptionalStarList(startnum: 1, endnum: 10, complete: { (response) in
            if let models = response as? [MarketListStarModel] {
                if models.count < 10 {
                    self.footer?.isHidden = true
                } else {
                    self.footer?.isHidden = false
                }
                self.reloadWithData(datas: models)
            }
        }, error: { (error) in
            
            
        })
    }
    func requestCustomData(type:Int) {
        
        AppAPIHelper.marketAPI().requestStarList(type: type, startnum: 1, endnum: 10, complete: { (response) in
            if let models = response as? [MarketListStarModel] {
                if models.count < 10 {
                    self.footer?.isHidden = true
                } else {
                    self.footer?.isHidden = false
                }
                self.reloadWithData(datas: models)
            }
        }) { (error) in
        }
    }
    func reloadWithData(datas:[MarketListStarModel]) {
        dataSource = datas
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
