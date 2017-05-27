//
//  NewsDetailViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import WebKit
import Kingfisher
class NewsDetailViewController: UIViewController {

    
    var newsModel:NewsModel?
    var urlString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomTitle(title: "资讯详情")
        let webView = WKWebView(frame: view.bounds)
        UIApplication.shared.statusBarStyle = .default;
        let url = URL(string: urlString!)
        let request = URLRequest(url: url!)
        webView.load(request)
        view.addSubview(webView)


    }


    @IBAction func shareAction(_ sender: Any) {
        UMSocialUIManager.showShareMenuViewInWindow { (platform, userInfo) in
            let shareObject = UMShareWebpageObject()
            shareObject.title = "星资讯"
            shareObject.descr = self.newsModel!.remarks
            shareObject.thumbImage = self.newsModel!.showpic_url
            shareObject.webpageUrl = self.newsModel!.link_url
            AppConfigHelper.share(type: platform, shareObject: shareObject, viewControlller: self)
            
            
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
