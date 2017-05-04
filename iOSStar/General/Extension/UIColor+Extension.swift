//
//  UIColor+Extension.swift
//  iOSStar
//
//  Created by J-bb on 17/5/4.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

extension UIColor {

    func imageWithColor() -> UIImage? {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        guard context != nil else {
            return nil
        }
        context!.setFillColor(self.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    
}
