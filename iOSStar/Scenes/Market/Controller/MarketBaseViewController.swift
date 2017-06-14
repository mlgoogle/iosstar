//
//  MarketBaseViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit


protocol ScrollStopDelegate {
    
    func subScrollViewDidScroll(scrollView: UIScrollView)
    func scrollStop()
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

    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollView.isUserInteractionEnabled = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isUserInteractionEnabled = true
        delegate?.scrollStop()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isSubView {
            delegate?.subScrollViewDidScroll(scrollView: scrollView)

        }
    }
}
