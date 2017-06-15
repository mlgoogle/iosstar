//
//  AllOrderViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class AllOrderViewController: DealBaseViewController {
    
    var identifiers = ["DealTitleMenuCell", "DealSingleRowCell"]
    @IBOutlet weak var tableView: UITableView!
    var titles = ["名称/代码","委托价/成交","价格","状态"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension AllOrderViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = ""
        if indexPath.row == 0 {
            identifier = identifiers.first!
        } else {
            identifier = identifiers.last!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if indexPath.row == 0 {
            let menuCell = cell as! DealTitleMenuCell
            menuCell.setTitles(titles: titles)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 38
        }
        return 80
    }
}
