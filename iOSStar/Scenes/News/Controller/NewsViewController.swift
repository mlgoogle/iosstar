//
//  NewsViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/20.
//  Copyright © 2017年 sum. All rights reserved.
//

import UIKit
import SDCycleScrollView

class NewsViewController: UIViewController, SDCycleScrollViewDelegate{
    @IBOutlet weak var tableView: UITableView!

    var bannerScrollView: SDCycleScrollView?
    var newsData:[NewsModel]?
    lazy var titleView:NewsNavigationView = {
       
        let view = NewsNavigationView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        return view
        
    }()
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        performSegue(withIdentifier: "showPubPage", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493098902992&di=74b063fe6c4fe1b887fe976d4c219bd3&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F61%2F00%2F61a58PICtPr_1024.jpg"
        bannerScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200), imageNamesGroup: [imageUrl, imageUrl, imageUrl, imageUrl])
        bannerScrollView?.delegate = self
        automaticallyAdjustsScrollViewInsets = false
        tableView.tableHeaderView = bannerScrollView
        tableView.separatorStyle = .none
        navigationController?.delegate = self;
        navigationController?.navigationBar.isTranslucent = true
        setImageWithAlpha(alpha: 0.0)
        let view = navigationController?.navigationBar.subviews.first?.subviews.first
        view?.isHidden = true
        navigationController?.navigationBar.addSubview(titleView)
        titleView.isHidden = true
        setNIMSDKLogin()
        requestNewsList()
    }
    
    func requestNewsList()  {
        
        AppAPIHelper.newsApi().requestNewsList(startnum: 1, endnum: 10, complete: { (response) -> ()? in
            
            self.newsData = response as? [NewsModel]
            self.tableView.reloadData()
            return nil
        }, error: errorBlockFunc())
    }
    func setNIMSDKLogin() {
//        NIMSDK.shared().loginManager.login("13569365932", token: "7d5d9d249d18b92b72c1133c61dd9a9c") { (error) in
//            
//            if error == nil  {
//                
//            }
//            
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollViewDidScroll(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        titleView.isHidden = true
    }
}

extension NewsViewController: UIScrollViewDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    func setImageWithAlpha(alpha:CGFloat) {

        let color = UIColor(red: 146.0 / 255.0, green: 18.0 / 255.0, blue: 36.0/255.0, alpha: alpha)
        if alpha > 1 {
            navigationController?.navigationBar.isTranslucent = false
            titleView.isHidden = false
        } else {
            titleView.isHidden = true
            navigationController?.navigationBar.isTranslucent = true
        }
        navigationController?.navigationBar.setBackgroundImage(color.imageWithColor(), for: .default)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = 1 - ((200 - scrollView.contentOffset.y) / 200)
        setImageWithAlpha(alpha: alpha)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData == nil ? 0 : newsData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as! NewsListCell
        
        cell.setData(data:newsData![indexPath.row])
        
        return cell
    }
    

}
