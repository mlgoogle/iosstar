//
//  MarketBaseViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit


protocol ScrollStopDelegate {
    
    func scrollViewIsStop()
}

class MarketBaseViewController: UIViewController, UIScrollViewDelegate{
    var starCode:String?
    var delegate:ScrollStopDelegate?
    var scrollView:UIScrollView?
    var isSubView = true
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewScrollEnabled(scroll:Bool) {
        if isSubView {
          scrollView?.isScrollEnabled = scroll
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        view.endEditing(true)
        if isSubView {            
            if scrollView.contentOffset.y < 0 {
               scrollView.isScrollEnabled = false
                delegate?.scrollViewIsStop()
            }
        }
    }
}
