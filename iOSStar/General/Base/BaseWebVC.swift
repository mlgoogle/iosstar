//
//  BaseWebVC.swift
//  iOSStar
//
//  Created by sum on 2017/6/1.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import WebKit
class BaseWebVC: UIViewController {

  
    var loadRequest = "" {
        didSet {
           webView?.loadRequest(URLRequest.init(url: NSURL.fileURL(withPath: loadRequest)))
        }
    }
    var navtitle = ""
    var webView : UIWebView?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navtitle
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height-64))
        let url = URL(string:loadRequest)
        let request = URLRequest(url: url!)
        webView.load(request)
        view.addSubview(webView)
        
    }

}
