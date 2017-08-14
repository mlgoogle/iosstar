//
//  NewVC.swift
//  wp
//
//  Created by mu on 2017/5/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class NewVC: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.masksToBounds = true
        guard AppConfigHelper.shared().updateModel != nil else {
            return
        }
        sureBtn.backgroundColor = UIColor(hexString: AppConst.Color.main)
        timeLabel.text = "发布时间:\(AppConfigHelper.shared().updateModel!.newAppReleaseTime)"
        versionLabel.text = "版本:\(AppConfigHelper.shared().updateModel!.newAppVersionName)"
        mLabel.text = "大小:\(AppConfigHelper.shared().updateModel!.newAppSize)M"
        contentLabel.text = AppConfigHelper.shared().updateModel!.newAppUpdateDesc
    }

    //确认
    @IBAction func sureBtnTapped(_ sender: Any) {
        guard AppConfigHelper.shared().updateModel != nil else {
            return
        }
        if AppConfigHelper.shared().updateModel!.isForceUpdate == 0 {
            UIApplication.shared.openURL(URL.init(string: "https://fir.im/starShareUser")!)
            return
        }
        dismissController()
    }
}
