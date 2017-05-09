//
//  MenuSubViewCell.swift
//  iOSStar
//
//  Created by J-bb on 17/4/27.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MenuSubViewCell: UICollectionViewCell {
  
    lazy var tableView:UITableView = {

        let tableView = UITableView(frame: CGRect(x: 0, y: 24, width: kScreenWidth, height: kScreenHeight - 90 - 44), style: .plain)

        return tableView
    }()
    
    
    
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
    
    
    
    
}

extension MenuSubViewCell:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubViewItemCell", for: indexPath)
        
        return cell
    }
    
}
