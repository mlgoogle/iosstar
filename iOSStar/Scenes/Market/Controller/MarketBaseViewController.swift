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
    
    var delegate:ScrollStopDelegate?
    var scrollView:UIScrollView?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewScrollEnabled(scroll:Bool) {
        scrollView?.isScrollEnabled = scroll
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            delegate?.scrollViewIsStop()
        }
    }
}
