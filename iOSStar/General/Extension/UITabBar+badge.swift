//
//  UITabBar+badge.swift
//  iOSStar
//
//  Created by MONSTER on 2017/6/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
import UIKit

let TabbarItemNums = 4.0

extension UITabBar {
 
    // 显示小红点
    func showshowBadgeOnItemIndex(index : Int)  {
        
         //新建小红点
        let redDotView = UIView()
        redDotView.tag = 999 + index
        redDotView.layer.cornerRadius = 5
        redDotView.backgroundColor = UIColor.red
        let tabBarFrame = self.frame
        
        let redCenterX  = (Double(index) + 0.6) / TabbarItemNums;
        let redDotViewX = ceilf(Float(redCenterX) * Float(tabBarFrame.size.width))
        let redDotViewY = ceilf(0.01 * Float(tabBarFrame.size.width))
        
        redDotView.frame = CGRect(x: CGFloat(redDotViewX), y: CGFloat(redDotViewY), width: 10, height: 10)
        
        self.addSubview(redDotView)
        
    }

    // 移除小红点
    func removeBadgeOnItemIndex(index : Int) {
        for subView: UIView in self.subviews as [UIView] {
            if subView.tag == 999 + index {
                subView.removeFromSuperview()
            }
        }
    }
    
    //隐藏小红点
    func hideBadgeOnItemIndex(index: Int) {
        
        self.removeBadgeOnItemIndex(index: index)
        
    }
}
