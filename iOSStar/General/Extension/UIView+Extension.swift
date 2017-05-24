//
//  UIView+Extension.swift
//  iOSStar
//
//  Created by J-bb on 17/5/24.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation


extension UIView{
    func setCornoerRadius(byRoundingCorners: UIRectCorner,cornerRadii: CGSize) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: byRoundingCorners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
