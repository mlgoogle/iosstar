//
//  Label-Extension.swift
//  iOSStar
//
//  Created by J-bb on 17/5/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
extension UILabel {
    func setAttributeText(text:String,firstFont:CGFloat, secondFont:CGFloat, firstColor:UIColor, secondColor:UIColor, range:NSRange) {
        textColor = firstColor
        font = UIFont.systemFont(ofSize: firstFont)
        let attributeText = NSMutableAttributedString(string: text)
        let attributes:[String : AnyObject] = [NSFontAttributeName : UIFont.systemFont(ofSize: secondFont), NSForegroundColorAttributeName : secondColor]
        attributeText.addAttributes(attributes, range: range)
        attributedText = attributeText
    }
}
