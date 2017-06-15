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
        YD_CountDownHelper.shared.start()
        setCustomTitle(title: "明星热度")
        translucent(clear: true)
        let color = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(color.imageWithColor(), for: .default)
        automaticallyAdjustsScrollViewInsets = false
        menuView = MarketMenuView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight))
        menuView?.navigationController = navigationController
        menuView?.items = ["明星"]
        menuView?.menuView?.isScreenWidth = true
        view.addSubview(menuView!)
        
        perform(#selector(setTypes), with: nil, afterDelay: 0.5)
    }

    func setTypes() {
        menuView?.types = [MarketClassifyModel]()
    }
    
    func requestTypeList() {
        AppAPIHelper.marketAPI().requestTypeList(complete: { (response) in
            if var models = response as? [MarketClassifyModel] {
                var titles = [String]()
              //  let customModel = MarketClassifyModel()
                //customModel.name = "自选"
                //models.insert(customModel, at: 0)
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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("--------marketLsit---------结束----------------")
        YD_CountDownHelper.shared.marketListRefresh = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("--------marketLsit---------开始----------------")
        YD_CountDownHelper.shared.marketListRefresh = { [weak self] (result)in
            self?.menuView?.requestDataWithIndexPath()
            
        }
    }
}
