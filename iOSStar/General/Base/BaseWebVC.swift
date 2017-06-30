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
        let webView = WKWebView(frame: view.bounds)
//        let webView = WKWebView(frame: CGRect(x: 0, y: 64, width: view.width, height: view.height))
        let url = URL(string: loadRequest)
        let request = URLRequest(url: url!)
        webView.load(request)
        view.addSubview(webView)
        
        // Do any additional setup after loading the view.
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
