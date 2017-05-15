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

    var bannerModels:[BannerModel]?
    var bannerScrollView: SDCycleScrollView?
    var newsData:[NewsModel]?
    lazy var titleView:NewsNavigationView = {
        let view = NewsNavigationView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        return view
        
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollViewDidScroll(tableView)
        titleView.setTime()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.setStatusBarHidden(false, with: .none)
        titleView.isHidden = true

        
        
        /**
         - 待修复，点击顶部滑动到最上部功能因隐藏状态栏失效
         */
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(scrollToTop))
        navigationController?.navigationBar.addGestureRecognizer(tapGes)
        navigationController?.navigationBar.isUserInteractionEnabled = true
        setUserInterraction()
    }
    func setUserInterraction() {
        
        for view in (navigationController?.navigationBar.subviews)! {
            view.isUserInteractionEnabled = true
        }
    }
    
    func scrollToTop() {
        
        tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .bottom, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        setupBannerView()
        setupNavigation()
        requestNewsList()
        requestBannerList()
    }
    func setupNavigation() {
        navigationController?.delegate = self;
        navigationController?.navigationBar.isTranslucent = true
        setImageWithAlpha(alpha: 0.0)
        let view = navigationController?.navigationBar.subviews.first?.subviews.first
        view?.isHidden = true
        navigationController?.navigationBar.addSubview(titleView)
        titleView.isHidden = true
    }
    func setupBannerView() {
        bannerScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200), imageNamesGroup: [""])
        bannerScrollView?.delegate = self
        bannerScrollView?.autoScrollTimeInterval = 3.0
        automaticallyAdjustsScrollViewInsets = false
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 210))
        backView.addSubview(bannerScrollView!)
        backView.backgroundColor = UIColor(hexString: "EFF3F6")
        tableView.tableHeaderView = backView
        tableView.separatorStyle = .none

    }
    
    func requestBannerList() {
        AppAPIHelper.newsApi().requestBannerList(complete: { (response)  in
            if let models = response as? [BannerModel] {
                self.bannerModels = models
                var bannersUrl:[String] = []
                
                for model in models {
                    bannersUrl.append(model.pic_url)
                }
            self.bannerScrollView?.imageURLStringsGroup = bannersUrl
            }
            
        }, error: errorBlockFunc())
        
    }
    
    func requestNewsList()  {
        
        AppAPIHelper.newsApi().requestNewsList(startnum: 1, endnum: 10, complete: { (response)  in
            self.newsData = response as? [NewsModel]
            self.tableView.reloadData()
        }, error: errorBlockFunc())
    }

    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
        
        performSegue(withIdentifier: "showPubPage", sender: index)
    }

}

extension NewsViewController: UIScrollViewDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource{


    
    func setImageWithAlpha(alpha:CGFloat) {
        var color:UIColor?
        if alpha > 1 {
            titleView.setTime()
            UIApplication.shared.setStatusBarHidden(true, with: .none)
            navigationController?.navigationBar.isTranslucent = false
            titleView.isHidden = false
            color = UIColor(red: 146.0 / 255.0, green: 18.0 / 255.0, blue: 36.0/255.0, alpha: 1)
            
        } else {
            titleView.setTime()
            UIApplication.shared.setStatusBarHidden(false, with: .none)
            titleView.isHidden = true
            navigationController?.navigationBar.isTranslucent = true
            color = UIColor(red: 146.0 / 255.0, green: 18.0 / 255.0, blue: 36.0/255.0, alpha: 0.0)
        }
        navigationController?.navigationBar.setBackgroundImage(color!.imageWithColor(), for: .default)
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
        return newsData == nil ? 0 : newsData!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as! NewsListCell
        
        cell.setData(data:newsData![indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newsToDeatail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsToDeatail" {
            
            let vc = segue.destination as! NewsDetailViewController
            let indexPath = sender as! IndexPath
            let model = newsData![indexPath.row]
            vc.urlString = model.link_url
            
        } else if segue.identifier == "showPubPage" {
            
            let index = sender as! Int
            let vc = segue.destination as! PublisherPageViewController
            vc.bannerModel = bannerModels?[index]
        }
    }
}
