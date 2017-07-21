//
//  UIBarExtension.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
import UIKit
extension UINavigationBar {
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView!.isHidden = true
    }
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView!.isHidden = false
    }
    func HideLine(){
        self.setBackgroundImage(UIImage(), for: .default)
        self.isTranslucent = false
        self.shadowImage = UIImage()

    }
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.classForCoder()) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(view: subview) {
                
                return imageView
            }
        }
        return nil
    }
}
extension UIToolbar {
    func hideHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
        navigationBarImageView!.isHidden = true
    }
    func showHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
        navigationBarImageView!.isHidden = false
    }
    private func hairlineImageViewInToolbar(view: UIView) -> UIImageView? {
        if view.isKind(of:  UIImageView()  as! AnyClass) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInToolbar(view: subview) {
                return imageView
            }
        }
        return nil
    }
}

