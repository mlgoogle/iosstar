//
//  NewsViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/20.
//  Copyright © 2017年 sum. All rights reserved.
//

import UIKit
import SDCycleScrollView

class NewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var bannerScrollView: SDCycleScrollView?
    
    lazy var titleView:NewsNavigationView = {
       
        let view = NewsNavigationView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        return view
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493098902992&di=74b063fe6c4fe1b887fe976d4c219bd3&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F61%2F00%2F61a58PICtPr_1024.jpg"
        bannerScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200), imageNamesGroup: [imageUrl, imageUrl, imageUrl, imageUrl])
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

        let color = UIColor(red: 24.0 / 255.0, green: 92.0 / 255.0, blue: 165.0/255.0, alpha: alpha)
        if alpha > 1 {
            navigationController?.navigationBar.isTranslucent = false
            titleView.isHidden = false
        } else {
            titleView.isHidden = true
            navigationController?.navigationBar.isTranslucent = true
        }
        navigationController?.navigationBar.setBackgroundImage(imageWithColor(color: color), for: .default)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = 1 - ((200 - scrollView.contentOffset.y) / 200)
        setImageWithAlpha(alpha: alpha)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath)
        return cell
    }
    
    func imageWithColor(color:UIColor) -> UIImage? {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        guard context != nil else {
            return nil
        }
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}
