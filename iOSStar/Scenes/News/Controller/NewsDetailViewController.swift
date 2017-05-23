//
//  NewsDetailViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import WebKit
class NewsDetailViewController: UIViewController {

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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
