//
//  MarketDetaiBaseInfoViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
protocol RefreshImageDelegate {
    func refreshImage(imageUrl:String)
}
class MarketDetaiBaseInfoViewController: MarketBaseViewController {
    
    var achives:[AchiveModel]?
    var refreshImageDelegate:RefreshImageDelegate?

    var bannerDetailModel:BannerDetaiStarModel?
    var titles = ["1","个人简介", "主要经历", "主要成就"]
    var rows:[Int] = [1, 1, 10]
    var identifiers:[String] = ["MaketBannerCell","MarketInfoCell","MarketExperienceCell","MarketExperienceCell"]
    var expericences:[ExperienceModel]?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = tableView
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 474))
        tableView.register(PubInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: AppConst.RegisterIdentifier.PubInfoHeaderView.rawValue)
        
        guard starCode != nil else {
            return
        }
        requestInfos()
        requestExperience()
        requestAchive()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    func requestInfos() {
        AppAPIHelper.newsApi().requestStarInfo(code: starCode!, complete: { (response) in
            if let model = response as? BannerDetaiStarModel {
                self.bannerDetailModel = model
                self.refreshImageDelegate?.refreshImage(imageUrl: model.pic_url)
                self.tableView.reloadData()
            }
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
    func requestAchive() {
        AppAPIHelper.marketAPI().requestStarArachive(code:  starCode!, complete: { (response) in
            if let models =  response as? [AchiveModel] {
                self.achives = models
                self.tableView.reloadSections(IndexSet(integer: 3), with: .none)
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
            if bannerDetailModel != nil {
                bannerCell.banner.imageURLStringsGroup = [bannerDetailModel!.pic_url]
            }
        case 1:
            let infoCell = cell as! MarketInfoCell
            
            infoCell.setData(model:bannerDetailModel)

        case 2:
            let expericenCell = cell as! MarketExperienceCell
           
            let model = expericences![indexPath.row]
            expericenCell.setTitle(title: model.experience)
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarketExperienceCell", for: indexPath) as! MarketExperienceCell
            
            let model = achives?[indexPath.row]
            cell.setTitle(title: (model?.achive)!)
            return cell
        default:
            break
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return expericences?.count ?? 0
        } else if section == 3 {
            return achives?.count ?? 0
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
        case 3:
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
        if section != 0 {
            view.setTitle(title: titles[section])
            return view
        }
        return nil
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  4
    }
}
