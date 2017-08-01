//
//  GuideVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/1.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class GuideVC: UIViewController {
    var guideType: AppConst.guideKey?
    var handleBlock: CompleteBlock?
    private lazy var contentBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.frame = self.view.frame
        btn.backgroundColor = UIColor.black
        btn.alpha = 0.5
        btn.addTarget(self, action:#selector(contentBtnTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private var contentImage: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        contentImage.isUserInteractionEnabled = true
        contentImage.frame = view.frame
        view.addSubview(contentImage)
        view.addSubview(contentBtn)
    }
    
    func setGuideContent(_ type: AppConst.guideKey) {
//        contentBtn.setImage(UIImage.init(named: type.rawValue), for: .normal)
        contentImage.image = UIImage.init(named: type.rawValue)
        guideType = type
    }
    
    func contentBtnTapped(_ btn: UIButton) {
        if handleBlock != nil{
            handleBlock!(self)
        }
    }
}
