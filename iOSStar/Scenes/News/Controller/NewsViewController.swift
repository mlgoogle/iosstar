//
//  NewsViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/20.
//  Copyright © 2017年 sum. All rights reserved.
//

import UIKit
import SDCycleScrollView
import MJRefresh

private let alphaMargin:CGFloat = 136.0

class NewsViewController: UIViewController, SDCycleScrollViewDelegate{
    @IBOutlet weak var tableView: UITableView!

    var hasCheck = false
    var isRefresh = true
    var header:MJRefreshNormalHeader?
    var footer:MJRefreshAutoNormalFooter?
    var bannerModels:[BannerModel]?
    var bannerScrollView: SDCycleScrollView?
    var newsData:[NewsModel]?
    lazy var titleView:NewsNavigationView = {
        let view = NewsNavigationView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        view.backgroundColor = UIColor(hexString: AppConst.Color.main)
        return view
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !hasCheck {
            if AppConfigHelper.shared().updateModel != nil {
                hasCheck = true
                if AppConfigHelper.shared().checkUpdate() {
                    showUpdateInfo()
                }
            }
        }
        scrollViewDidScroll(tableView)
        titleView.setTime()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !ShareDataModel.share().isShowInWindows {
        UIApplication.shared.setStatusBarHidden(false, with: .none)
        }
        titleView.isHidden = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupBannerView()
        setupNavigation()
        requestNewsList()
        requestBannerList()
        header = MJRefreshNormalHeader(refreshingBlock: {
            self.isRefresh = true
            self.requestNewsList()
            self.requestBannerList()
        })
        tableView.mj_header = header
        
        footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            
            self.isRefresh = false
            self.requestNewsList()
        })
        tableView.mj_footer = footer
    }
    
    func setupNavigation() {
        navigationController?.delegate = self;
        navigationController?.navigationBar.isTranslucent = true
        setImageWithAlpha(alpha: 0.0)
        navigationController?.navigationBar.addSubview(titleView)
        titleView.isHidden = true
    }
    func setupBannerView() {
        bannerScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200), imageNamesGroup: [""])
        bannerScrollView?.delegate = self
        bannerScrollView?.placeholderImage = UIImage(named: "nodata_banner")
        bannerScrollView?.pageDotImage = UIImage(named: "page_yuan")
        bannerScrollView?.currentPageDotImage = UIImage(named: "page_tuoyuan")
        bannerScrollView?.bannerImageViewContentMode = .scaleAspectFill
        bannerScrollView?.autoScrollTimeInterval = 3.0
        automaticallyAdjustsScrollViewInsets = false
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 210))
        backView.addSubview(bannerScrollView!)
        backView.backgroundColor = UIColor(hexString: "EFF3F6")
        tableView.tableHeaderView = backView
        tableView.separatorStyle = .none
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.className())

    }

    
    
    
    func requestBannerList() {

        AppAPIHelper.newsApi().requestBannerList(complete: { (response)  in
            if let models = response as? [BannerModel] {
                print(models)
                self.bannerModels = models
                
                var bannersUrl:[String] = []
                for model in models {
                    model.pic_url = "http://\(model.pic_url)"
                    bannersUrl.append(model.pic_url)
                }
            self.bannerScrollView?.imageURLStringsGroup = bannersUrl
            }
            
        }, error: errorBlockFunc())
        
    }
    func endRefresh() {
        if header?.state == .refreshing {
            header?.endRefreshing()
        }
        if footer?.state == .refreshing {
            footer?.endRefreshing()
        }
    }
    func requestNewsList()  {
        var startNumber = 0
        if !isRefresh {
            
            startNumber = newsData == nil ? 0 : newsData!.count
        }
        
        AppAPIHelper.newsApi().requestNewsList(startnum: startNumber, endnum: startNumber + 10, complete: { (response)  in
            
            self.endRefresh()
            
            if let models = response as? [NewsModel] {
                if models.count < 10 {
                    self.footer?.isHidden = true
                } else {
                    self.footer?.isHidden = false   
                }
                if self.isRefresh {
                    self.newsData = models
                } else {
                    self.newsData?.append(contentsOf: models)
                }
            }

            self.tableView.reloadData()

        }, error: errorBlockFunc())
    }


    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {

        
        if (bannerModels?.count ?? 0) == 0 {
            return
        }
        

        performSegue(withIdentifier: "showPubPage", sender: index)
    }

}

extension NewsViewController: UIScrollViewDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource{

    
    func setImageWithAlpha(alpha:CGFloat) {
        if alpha > 1 {
            titleView.setTime()
            UIApplication.shared.setStatusBarHidden(true, with: .none)
            titleView.isHidden = false
            
            navigationController?.setNavigationBarHidden(false, animated: false)
            
        } else {
            titleView.setTime()
            if !ShareDataModel.share().isShowInWindows {
                UIApplication.shared.setStatusBarHidden(false, with: .none)
            }
            titleView.isHidden = true
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = 1 - ((alphaMargin - scrollView.contentOffset.y) / alphaMargin)
        setImageWithAlpha(alpha: alpha)
        if scrollView.contentOffset.y > 200 {
            let index = Int((scrollView.contentOffset.y - 200) / 100)
            let news = newsData?[index]
            guard news != nil else {
                return
            }
            titleView.setTitle(title: news!.times)
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if newsData?.count ?? 0 == 0 {
            return 500
        }
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if newsData?.count ?? 0 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataCell.className(), for: indexPath) as! NoDataCell
            
            cell.setImageAndTitle(image: UIImage(named: "nodata_news"), title: nil)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as! NewsListCell
        cell.setData(data:newsData![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if newsData?.count ?? 0 == 0 {
            return
        }
        performSegue(withIdentifier: "newsToDeatail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsToDeatail" {
            let vc = segue.destination as! NewsDetailViewController
            let indexPath = sender as! IndexPath
            let model = newsData![indexPath.row]
            let cell = tableView.cellForRow(at: indexPath) as! NewsListCell
            vc.shareImage = cell.newsImageView?.image
            vc.newsModel = model
        } else if segue.identifier == "showPubPage" {
            let index = sender as! Int
            guard bannerModels != nil else {
                return
            }
            let vc = segue.destination as! PublisherPageViewController
            vc.bannerModel = bannerModels?[index]
        }
    }
}
