//
//  MenuSubViewCell.swift
//  iOSStar
//
//  Created by J-bb on 17/4/27.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

protocol SubViewItemSelectDelegate {
    func selectItem(starModel:MarketListStarModel)
}
class MenuSubViewCell: UICollectionViewCell {
  
    lazy var tableView:UITableView = {

        let tableView = UITableView(frame: CGRect(x: 0, y: 24, width: kScreenWidth, height: kScreenHeight - 90 - 44), style: .grouped)

        return tableView
    }()
    var dataSource:[MarketListStarModel]?
    var delegate:SubViewItemSelectDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SubViewItemCell.self, forCellReuseIdentifier: "SubViewItemCell")
        contentView.addSubview(tableView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SubViewItemCell.self, forCellReuseIdentifier: "SubViewItemCell")
        contentView.addSubview(tableView)
    }

    
    func requestStarList(type:Int) {
        AppAPIHelper.marketAPI().requestStarList(type: type, startnum: 1, endnum: 10, complete: { (response) in
            if let models = response as? [MarketListStarModel] {
                self.dataSource = models
                self.tableView.reloadData()
            }
        }) { (error) in
        }
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
