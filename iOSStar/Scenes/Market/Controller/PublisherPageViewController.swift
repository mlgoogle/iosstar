//
//  PublisherPageViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/10.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD

class PublisherPageViewController: UIViewController {
    var code = "1001"
    var bannerModel:BannerModel?
    var titles = ["1","个人简介", "主要经历"]
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomTitle(title:"\(bannerModel!.name)（\(bannerModel!.code)）")
        tableView.register(PubInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: "PubInfoHeaderView")
        automaticallyAdjustsScrollViewInsets = false
        requestInfos()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func buyButtonAction(_ sender: Any) {
        SVProgressHUD.showInfo(withStatus: "完善中")
    }
    func requestInfos() {
        AppAPIHelper.newsApi().requestStarInfo(code: code, complete: { (response) in
            
            
        }, error: errorBlockFunc())
    }
}

extension PublisherPageViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "iconImageCell", for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 40
        }
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PubInfoHeaderView") as! PubInfoHeaderView
            header.setTitle(title:titles[section])
            return header
        } else {
            return nil
        }
    }
}
