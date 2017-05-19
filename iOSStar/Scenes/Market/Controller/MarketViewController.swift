//
//  MarketViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/20.
//  Copyright © 2017年 sum. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController {

    var menuView:MarketMenuView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomTitle(title: "明星热度")
        let lineView = navigationController?.navigationBar.subviews.first?.subviews.first
        lineView?.isHidden = true
        let color = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(color.imageWithColor(), for: .default)
        automaticallyAdjustsScrollViewInsets = false
        
        
        menuView = MarketMenuView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight))
        menuView?.items = ["自选","艺人","体育明星","网红","海外知名人士"]
        menuView?.navigationController = navigationController
    
        for _ in (menuView?.items!)! {
            let viewController = MarketSubViewController()
            menuView?.subViews?.append(viewController.view)
        }
        view.addSubview(menuView!)
        requestTypeList()

    }
    func requestTypeList() {
        AppAPIHelper.marketAPI().requestTypeList(complete: { (response) in
            if var models = response as? [MarketClassifyModel] {
                var titles = [String]()
                let customModel = MarketClassifyModel()
                customModel.name = "自选"
                titles.append(customModel.name)
                models.insert(customModel, at: 0)
                for model in models {
                    titles.append(model.name)
                }
                self.menuView?.items = titles
                self.menuView?.types = models
            }
            
        }, error: errorBlockFunc())
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func searchAction() {
        
    }

}
