//
//  DealDetailViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DealDetailViewController: DealBaseViewController ,DealScrollViewScrollDelegate,MenuViewDelegate{
    lazy var backView: DealScrollView = {
        let view = DealScrollView(frame: CGRect(x: 0, y: 40, width: kScreenWidth, height: kScreenHeight - 40))
        return view
    }()

    var menuView:YD_VMenuView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuView()
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(backView)
        backView.delegate = self
        addSubViews()

    }
    func setupMenuView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        layout.itemSize = CGSize(width: (kScreenWidth - 50) / 4, height: 30)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection =  .horizontal
        menuView = YD_VMenuView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30), layout: layout)
        menuView?.backgroundColor = UIColor.clear
        menuView?.isScreenWidth = true
        menuView?.isShowLineView = false
        menuView?.isSelectZoom = true
        let titles = ["当日成交","当日委托","历史委托","历史成交"]
        menuView?.itemData = titles as [AnyObject]?
        menuView?.reloadData()
        menuView?.delegate = self
        view.addSubview(menuView!)
    }
    func addSubViews() {
        let identifiers = ["DetailCommenViewController","DetailCommenViewController","DetailCommenViewController","DetailCommenViewController"]
        
        let types:[UInt16] = [6007, 6001, 6005, 6009]
        let stroyBoard = UIStoryboard(name: AppConst.StoryBoardName.Deal.rawValue, bundle: nil)
        var views = [UIView]()
        for (index,identifier) in identifiers.enumerated() {
            let vc = stroyBoard.instantiateViewController(withIdentifier: identifier) as! DetailCommenViewController
            vc.type = AppConst.DealDetailType(rawValue: types[index])!
            views.append(vc.view)
            vc.view.frame = CGRect(x: CGFloat(index) * kScreenWidth, y: 0, width: kScreenWidth, height: backView.frame.size.height - 64)
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
        let indexPath = IndexPath(item: index, section: 0)

         menuView?.reloadCollection(indexPath:indexPath)
    }
    

}
