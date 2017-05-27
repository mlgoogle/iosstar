
//
//  MarketDetailViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    

    var bottomScrollView:UIScrollView?
    var menuView:YD_VMenuView?
    var subViews = [UIView]()
    var starModel:MarketListStarModel?
    var currentVC:MarketBaseViewController?
    @IBOutlet weak var handleMenuView: ImageMenuView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomTitle(title: "\(starModel!.name)（\(starModel!.code)）")
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(MarketDetailMenuView.self, forHeaderFooterViewReuseIdentifier: "MarketDetailMenuView")
        requestLineData()
        setupSubView()
        handleMenuView.titles = ["求购", "转让", "粉丝见面会", "自选"]
        handleMenuView.delegate = self
    
    }
    func setupSubView() {
        let types:[String] = ["MarketDetaiBaseInfoViewController", "MarketFansListViewController", "MarketAuctionViewController", "MarketCommentViewController"]
        let storyboard = UIStoryboard(name: "Market", bundle: nil)
        for (index, type) in types.enumerated() {
            let vc = storyboard.instantiateViewController(withIdentifier: type) as! MarketBaseViewController
            addChildViewController(vc)
            vc.starModel = starModel
            vc.delegate = self
            vc.view.frame = CGRect(x: CGFloat(index) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight - 50 - 64 - 50)
            subViews.append(vc.view)
            vc.scrollViewScrollEnabled(scroll: false)
        }
        currentVC = childViewControllers.first as? MarketBaseViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func requestLineData() {
        AppAPIHelper.marketAPI().requestLineViewData(starcode: starModel!.code, complete: { (response) in
            if let models = response as? [LineModel] {
                LineModel.cacheLineData(datas: models)
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
            }
        }, error: errorBlockFunc())
    }
    

}

extension MarketDetailViewController:UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MenuViewDelegate, BottomItemSelectDelegate, ScrollStopDelegate{
    

    func itemDidSelectAtIndex(index:Int) {
        switch index {
        case 1:
            pushToDealPage()
        case 2:
            performSegue(withIdentifier: "meetFans", sender: nil)
        case 3:
            addOptinal()
        default:
            break
        }
    }
    func pushToDealPage() {
       let storyBoard = UIStoryboard(name: AppConst.StoryBoardName.Deal.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DealViewController")
        navigationController?.pushViewController(vc, animated: true)
    }

    func addOptinal() {
//        guard starModel  != nil else {return}
        AppAPIHelper.marketAPI().addOptinal(starcode: "1001", complete: { (response) in
            
        }, error: errorBlockFunc())
    }
    
    func menuViewDidSelect(indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.bottomScrollView?.contentOffset = CGPoint(x: kScreenWidth * CGFloat(indexPath.row), y: 0)
        }
    }
    
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MarketDetailMenuView") as! MarketDetailMenuView
        view.menuView.delegate = self
        menuView = view.menuView
        return  view
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            
            return kScreenHeight - 50 - 64 - 50
        }
        return 400
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            
            return 0.001
        }
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarketDetailSubViewCell", for: indexPath) as! MarketDetailSubViewCell
            bottomScrollView = cell.scrollView
            cell.scrollView.delegate = self
            cell.setSubViews(views: subViews)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketDetailCell", for: indexPath) as! MarketDetailCell
        cell.setData(datas: LineModel.getLineData(starCode:starModel!.code))
        cell.setStarModel(starModel: starModel!)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bottomScrollView {
            let index = Int(scrollView.contentOffset.x / kScreenWidth)
            let scrollEnbled = currentVC?.scrollView?.isScrollEnabled
            currentVC = childViewControllers[index] as? MarketBaseViewController
            currentVC?.scrollViewScrollEnabled(scroll: scrollEnbled!)
            menuView?.selected(index: index)
        } else if scrollView == tableView {
            if scrollView.contentOffset.y > 400 {
                tableView.isScrollEnabled = false
                currentVC?.scrollViewScrollEnabled(scroll: true)
            }
        }
    }
    func scrollViewIsStop() {
        tableView.isScrollEnabled = true
    }
}
