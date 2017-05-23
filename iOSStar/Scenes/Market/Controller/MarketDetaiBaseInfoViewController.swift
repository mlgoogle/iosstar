//
//  MarketDetaiBaseInfoViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketDetaiBaseInfoViewController: MarketBaseViewController {

    var rows:[Int] = [1, 1, 10]
    var identifiers:[String] = ["MaketBannerCell","MarketInfoCell","MarketExperienceCell"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = tableView
        tableView.register(PubInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: AppConst.RegisterIdentifier.PubInfoHeaderView.rawValue)
        requestBaseInfo()
        requestExperience()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    func requestBaseInfo() {
        AppAPIHelper.newsApi().requestStarInfo(code: "1001", complete: { (response) in
            
        }, error: errorBlockFunc())
    }
    func requestExperience() {
        AppAPIHelper.marketAPI().requestStarExperience(code: "1001", complete: { (response) in
            
        }, error: errorBlockFunc())
    }


}

extension MarketDetaiBaseInfoViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.section], for: indexPath)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows[section]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        case 1:
            return 170
        case 2:
            return 40
        default:
            return 0.0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.001
        }
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PubInfoHeaderView") as! PubInfoHeaderView
        if section == 1 {
            view.setTitle(title: "个人简介")
            return view
        }else if section == 2 {
            view.setTitle(title: "主要经历")
            return view
        }
        
        return nil  
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  3
    }
}
