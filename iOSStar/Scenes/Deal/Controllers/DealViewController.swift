//
//  DealViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DealViewController: RedBackItemViewController,DealScrollViewScrollDelegate,MenuViewDelegate{

    lazy var backView: DealScrollView = {
        let view = DealScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        return view
    }()
    var menuView:YD_VMenuView?
    var starListModel:MarketListStarModel?
    
    var realTimeData:RealTimeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuView()
        view.addSubview(backView)
        backView.delegate = self
        addSubViews()
    }
    func setupMenuView() {
        navigationController?.navigationBar.setBackgroundImage(UIColor.white.imageWithColor(), for: .default)

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 28)
        layout.minimumInteritemSpacing = (kScreenWidth - 44 - 28 - 30 * 5) / 4
        layout.minimumLineSpacing = (kScreenWidth - 44 - 28 - 30 * 5) / 4
        layout.scrollDirection =  .horizontal
        menuView = YD_VMenuView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 44, height: 40), layout: layout)
        menuView?.backgroundColor = UIColor.clear
        menuView?.isScreenWidth = true
        menuView?.items = ["求购","转让","已购","订单","明细"]
        menuView?.reloadData()
        menuView?.delegate = self
        navigationItem.titleView = menuView
        perform(#selector(refreshSelect), with: nil, afterDelay: 0.5)
    }
    
    func refreshSelect() {
        menuView?.selected(index: 0)
    }
    func addSubViews() {
        let identifiers = ["BuyOrSellViewController","BuyOrSellViewController","BuyYetViewController","AllOrderViewController","DealDetailViewController"]
        
        let stroyBoard = UIStoryboard(name: AppConst.StoryBoardName.Deal.rawValue, bundle: nil)
        var views = [UIView]()
        for (index,identifier) in identifiers.enumerated() {
            let vc = stroyBoard.instantiateViewController(withIdentifier: identifier) as! DealBaseViewController
            if index == 0 {
                vc.dealType = AppConst.DealType.buy
            }
            vc.starListModel = starListModel
            vc.realTimeData = realTimeData
            views.append(vc.view)
            vc.view.frame = CGRect(x: CGFloat(index) * kScreenWidth, y: 64, width: kScreenWidth, height: backView.frame.size.height - 64)
            addChildViewController(vc)
        }
        backView.setSubViews(customSubViews: views)

    }
    
    
    
    //menuDelegate
    func menuViewDidSelect(indexPath: IndexPath) {
        backView.moveToIndex(index: indexPath.item)
    }
    //backViewDelegate
    func scrollToIndex(index: Int) {
        menuView?.selected(index: index)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
