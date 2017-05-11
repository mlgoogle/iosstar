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

        title = "资讯详情"

        let webView = WKWebView(frame: view.bounds)
        
        UIApplication.shared.statusBarStyle = .lightContent;

        let url = URL(string: urlString!)
        let request = URLRequest(url: url!)
        webView.load(request)
        view.addSubview(webView)
        
        
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
