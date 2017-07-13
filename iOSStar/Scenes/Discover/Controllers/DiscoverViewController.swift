//
//  DiscoverViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/6.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, MenuViewDelegate{

    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 40, width: kScreenWidth, height: kScreenHeight - 40 - 44 - 64))
        
        scrollView.contentSize = CGSize(width: kScreenWidth * 2, height: 0)
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    var menuView:YD_VMenuView?
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isStatusBarHidden = false
        initMenuView()
    }
    func initMenuView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth / 2, height: 40)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        menuView = YD_VMenuView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 40), layout: layout)
        view.addSubview(menuView!)
        menuView?.isScreenWidth = true
        let titles = ["抢购明星", "明星互动"]
        menuView?.itemData = titles as [AnyObject]?
        menuView?.reloadData()
        menuView?.delegate = self
        view.addSubview(scrollView)
        addChildViewControllers()
    }
    func addChildViewControllers() {
        let storyBoard = UIStoryboard(name: AppConst.StoryBoardName.Discover.rawValue, bundle: nil)
        let identifiers = [BuyStarTimeViewController.className(), StarInteractiveViewController.className()]
        for (index, identifier) in identifiers.enumerated() {
            let vc = storyBoard.instantiateViewController(withIdentifier: identifier!)
            addChildViewController(vc)
            vc.view.frame = CGRect(x: CGFloat(index) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight - 40 - 44 - 64 )
            scrollView.addSubview(vc.view)
        }
    }
    func menuViewDidSelect(indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) { 
            self.scrollView.contentOffset = CGPoint(x: CGFloat(indexPath.row) * kScreenWidth, y: 0)
        }
    }
    @IBAction func searchAction(_ sender: Any) {
        let stroyBoard = UIStoryboard(name: AppConst.StoryBoardName.Markt.rawValue, bundle: nil)
        let vc =  stroyBoard.instantiateViewController(withIdentifier: MarketSearchViewController.className())
        navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
