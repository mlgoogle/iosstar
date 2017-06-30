//
//  UIBarButtonItem+Category.swift
//  iOSStar
//
//  Created by MONSTER on 2017/6/21.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
import UIKit


extension UIBarButtonItem {
    
    class func creatBarButtonItem(title : String , target : Any? ,action : Selector) -> UIBarButtonItem {
        
        let btn = UIButton()

        var countStringTitle = title
        // 是否以 "+" 结尾
        if countStringTitle.hasSuffix("+") {
            countStringTitle.remove(at: countStringTitle.index(before: countStringTitle.endIndex))
        }
        let titleNum = Int(countStringTitle)
        if titleNum! <= 9 {
            btn.width = 20
            btn.height = 20
        } else {
            btn.width = 20 + 10
            btn.height = 20
        }
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = true;
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }
    
    
    class func creatRightBarButtonItem(title:String, target : Any? ,action : Selector) -> UIBarButtonItem {
        
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        let color = UIColor(hexString: AppConst.Color.main)
        btn.setTitleColor(color, for: .normal)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
        
    }

}
