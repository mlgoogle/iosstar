//
//  MarketBaseViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh

protocol ScrollStopDelegate {
    
    func subScrollViewDidScroll(scrollView: UIScrollView)
    func scrollStop()
    func scrollBegin()
}


class MarketBaseViewController: UIViewController, UIScrollViewDelegate{
    var starCode:String?
    var starName:String?
    var starPic:String?
    var footer:MJRefreshAutoNormalFooter?
    var delegate:ScrollStopDelegate?
    var totalCount:Int = 0
    var scrollView:UIScrollView?
    var isSubView = true
    //正在滑动
    var isScroll = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if !isSubView {
            scrollView.isUserInteractionEnabled = true
        }
        
        delegate?.scrollBegin()
        YD_CountDownHelper.shared.pause()
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegate?.scrollStop()
        YD_CountDownHelper.shared.start()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
        delegate?.scrollBegin()
        isScroll = true
        YD_CountDownHelper.shared.pause()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if !isSubView {
            scrollView.isUserInteractionEnabled = true
        }
        isScroll = false
        delegate?.scrollStop()
        YD_CountDownHelper.shared.start()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isSubView {
            delegate?.subScrollViewDidScroll(scrollView: scrollView)

        }
    }
}
