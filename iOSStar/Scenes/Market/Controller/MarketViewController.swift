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
        translucent(clear: true)
        let color = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(color.imageWithColor(), for: .default)
        automaticallyAdjustsScrollViewInsets = false
        menuView = MarketMenuView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight))
        menuView?.navigationController = navigationController
        menuView?.items = ["自选","明星"]
        view.addSubview(menuView!)
        requestTypeList()

    }
    func requestTypeList() {
        AppAPIHelper.marketAPI().requestTypeList(complete: { (response) in
            if var models = response as? [MarketClassifyModel] {
                var titles = [String]()
                let customModel = MarketClassifyModel()
                customModel.name = "自选"
                models.insert(customModel, at: 0)
                for model in models {
                    titles.append(model.name)
                }
                self.menuView?.items = titles
                for _ in (self.menuView?.items!)! {
                    let viewController = MarketSubViewController()
                    self.menuView?.subViews?.append(viewController.view)
                }
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
