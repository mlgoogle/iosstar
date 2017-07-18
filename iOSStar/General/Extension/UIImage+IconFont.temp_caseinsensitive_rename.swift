//
//  UIimage+IconFont.swift
//  iOSStar
//
//  Created by sum on 2017/7/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
extension UIImage {

    class func imageWith(_ iconName: String, fontSize: CGSize, fontColor:UIColor?) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(fontSize, false, UIScreen.main.scale)
        let label = UILabel.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: fontSize))
        label.font = UIFont.init(name: "iconfont", size:fontSize.height)
        label.text = iconName
        if fontColor != nil{
            label.textColor = fontColor
        }
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
