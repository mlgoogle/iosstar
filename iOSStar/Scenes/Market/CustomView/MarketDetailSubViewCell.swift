//
//  MarketDetailSubViewCell.swift
//  iOSStar
// 
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketDetailScrollView: UIView {

    var scrollContenView:UIView = {
       
        let view = UIView()
        
        return view
    }()
    var scrollView:UIScrollView = {
        
       let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        
        return scrollView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(scrollView)
        scrollView.contentSize = CGSize(width: kScreenWidth * 4, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    func setSubViews(views:[UIView]) {
        for subView in views {
            scrollView.addSubview(subView)
        }
    }
    



}
