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
    var expericences:[ExperienceModel]?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = tableView
        tableView.register(PubInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: AppConst.RegisterIdentifier.PubInfoHeaderView.rawValue)
        
        guard starCode != nil else {
            return
        }
        requestBaseInfo()
        requestExperience()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    func requestBaseInfo() {

        AppAPIHelper.newsApi().requestStarInfo(code: starCode!, complete: { (response) in
            
        }, error: errorBlockFunc())
    }
    func requestExperience() {
        
        AppAPIHelper.marketAPI().requestStarExperience(code: starCode!, complete: { (response) in
            if let models =  response as? [ExperienceModel] {
                self.expericences = models
                self.tableView.reloadSections(IndexSet(integer: 2), with: .none)
            }
        }, error: errorBlockFunc())
    }


}

extension MarketDetaiBaseInfoViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.section], for: indexPath)
        switch indexPath.section {
        case 0:
            let bannerCell = cell as! MaketBannerCell
            bannerCell.banner.imageURLStringsGroup = ["http://chuantu.biz/t5/94/1495791704x2890171719.png"]
        case 2:
            let expericenCell = cell as! MarketExperienceCell
           
            let model = expericences![indexPath.row]
            expericenCell.setTitle(title: model.experience)
            
        default:
            break
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return expericences == nil ? 0 :  expericences!.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        case 1:
            return 150
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

    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
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
