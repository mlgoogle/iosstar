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


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "资讯详情"

        let webView = WKWebView(frame: view.bounds)
        
        UIApplication.shared.statusBarStyle = .lightContent;

        let url = URL(fileURLWithPath: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493098902992&di=74b063fe6c4fe1b887fe976d4c219bd3&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F61%2F00%2F61a58PICtPr_1024.jpg")
        let request = URLRequest(url: url)
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
