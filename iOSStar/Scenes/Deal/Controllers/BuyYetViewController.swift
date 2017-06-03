
//
//  BuyYetViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class BuyYetViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var identifiers = ["DealPropertyCell","DealTitleMenuCell", "DealDoubleRowCell"]
    var titles = ["名称/市值（元）","持有/可转（秒）","现价/成本（秒）","盈亏（元）"]
    var sectionHeights:[CGFloat] = [100.0, 38, 80.0]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.section], for: indexPath)
        switch indexPath.section {
        case 1:
            let proCell = cell as! DealTitleMenuCell
            proCell.setTitles(titles:titles)
        default:
            break
        }
        return cell
    }
}
