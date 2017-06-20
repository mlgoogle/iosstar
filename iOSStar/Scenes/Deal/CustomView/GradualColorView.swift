//
//  GradualColorView.swift
//  渐变色
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class GradualColorView: UIView {
    var isShowImage = true {
        didSet {
            imageView.isHidden = !isShowImage
        }
    }
    var realWidth: CGFloat = kScreenWidth - 50
    var percent:CGFloat = 0.0
    var completeColors:[UIColor] = []
    lazy var imageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "auction_button"))
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return imageView
        
    }()
    var isRound = false
    var subLayer:CAGradientLayer?
    
     override init(frame: CGRect) {
        super.init(frame: frame)


        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubViews()
    }
    func setupSubViews() {

        addSubview(imageView)
        imageView.center = CGPoint(x: 0, y: frame.size.height / 2)
    }


    convenience init(frame: CGRect, percent:CGFloat, completeColors:[UIColor], backColor:UIColor) {
        self.init(frame:frame)
        backgroundColor = backColor
        self.percent = percent
        self.completeColors = completeColors

    }
    func addGradualColorLayer(isRound:Bool) {
        self.isRound = isRound
        subLayer?.removeFromSuperlayer()
        var colors:[CGColor] = []
        if completeColors.count == 0 {
            completeColors.append(UIColor(red: 251 / 255.0, green: 153 / 255.0, blue: 56 / 255.0, alpha: 1.0))
            completeColors.append(UIColor(red: 251 / 255.0, green: 106 / 255.0, blue: 56 / 255.0, alpha: 1.0))
        }
        for color in completeColors {
            colors.append(color.cgColor)
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: realWidth * CGFloat(percent), height: frame.size.height)
        if isShowImage {
            imageView.center = CGPoint(x: realWidth * CGFloat(percent), y: imageView.center.y)
            layer.insertSublayer(gradientLayer, below: imageView.layer)
        } else {
            layer.addSublayer(gradientLayer)
        }
        subLayer = gradientLayer

        if isRound {
            subLayer?.cornerRadius = 8
        }
    }
    
    func animation(percent:CGFloat, width:CGFloat) {
        self.percent = percent
        realWidth = width
        subLayer?.frame = CGRect(x: 0, y: 0, width: width * percent, height: frame.size.height)
        if isShowImage {
            imageView.center = CGPoint(x: frame.size.width * percent, y: imageView.center.y)
        }
    }
    
}

class DoubleGradualView: GradualColorView {
    
    override func addGradualColorLayer(isRound: Bool) {
        self.isRound = isRound
        subLayer?.removeFromSuperlayer()
        var colors:[CGColor] = []
        for color in completeColors {
            colors.append(color.cgColor)
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.5, 0.5]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: realWidth * CGFloat(percent), height: frame.size.height)
        if isShowImage {
            imageView.center = CGPoint(x: realWidth * CGFloat(percent), y: imageView.center.y)
            layer.insertSublayer(gradientLayer, below: imageView.layer)
        } else {
            layer.addSublayer(gradientLayer)
        }
        subLayer = gradientLayer
        
        if isRound {
            subLayer?.cornerRadius = 8
        }
    }
    
    func animation(locations:[NSNumber]) {
        subLayer?.locations = locations
        if isShowImage {
            imageView.center = CGPoint(x: frame.size.width * percent, y: imageView.center.y)
        }
    }
    
}
